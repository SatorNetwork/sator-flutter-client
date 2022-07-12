import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/challenges_binding.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/rss_item_binding.dart';
import 'package:satorio/binding/rss_list_binding.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/binding/shows_category_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_categories_controller.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/rss_item_controller.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/nft_order_type.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/sao_wallet.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_category.dart';
import 'package:satorio/domain/entities/shows_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/challenges_page.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/rss_item_page.dart';
import 'package:satorio/ui/page_widget/rss_list_page.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';
import 'package:satorio/ui/page_widget/shows_category_page.dart';
import 'package:webfeed/webfeed.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin, NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<SaoWallet>> saoWalletRx = Rx([]);

  late final Rx<List<NftItem>> nftHomeRx = Rx([]);
  final Rx<List<Show>> allShowsRx = Rx([]);
  final Rx<List<ShowCategory>> categoriesRx = Rx([]);
  final Rx<RssItem?> rssItemRx = Rx(null);

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxString quizHeadTitleRx = ''.obs;
  final RxString quizHeadMessageRx = ''.obs;
  final RxBool isHomeBalanceEnabledRx = false.obs;

  late ValueListenable<Box<Profile>> _profileListenable;
  late ValueListenable<Box<SaoWallet>> _saoWalletsListenable;
  late ValueListenable<Box<RssItem>> _rssItemsListenable;

  HomeController() {
    this._profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    this._saoWalletsListenable = _satorioRepository.saoWalletsListenable()
        as ValueListenable<Box<SaoWallet>>;

    _rssItemsListenable = _satorioRepository.rssItemsListenable()
        as ValueListenable<Box<RssItem>>;

    _loadNfts();
  }

  @override
  void onInit() {
    super.onInit();
    _loadAllShows();
    _loadCategories();
    _satorioRepository.updateRssItems();

    _satorioRepository
        .quizHeadTitleText()
        .then((value) => quizHeadTitleRx.value = value);

    _satorioRepository
        .quizHeadMessageText()
        .then((value) => quizHeadMessageRx.value = value);

    _satorioRepository
        .isHomeBalanceEnabled()
        .then((value) => isHomeBalanceEnabledRx.value = value);

    _profileListener();
    _profileListenable.addListener(_profileListener);

    _saoWalletsListener();
    _saoWalletsListenable.addListener(_saoWalletsListener);

    _rssItemsListener();
    _rssItemsListenable.addListener(_rssItemsListener);
  }

  @override
  void onClose() {
    _profileListenable.removeListener(_profileListener);
    _saoWalletsListenable.removeListener(_saoWalletsListener);
    _rssItemsListenable.removeListener(_rssItemsListener);
    super.onClose();
  }

  void refreshHomePage() {
    _loadNfts();

    _satorioRepository.updateProfile();
    _satorioRepository.updateWalletBalance();
    _satorioRepository.updateRssItems();

    _loadCategories();
    _loadAllShows();
  }

  void _loadNfts() {
    _satorioRepository
        .nftsFiltered(
            page: _initialPage,
            itemsPerPage: _itemsPerPage,
            orderType: NftOrderOnSaleType.onSale)
        .then((value) {
      nftHomeRx.value = value;
    });
  }

  void toChallenges() {
    Get.to(
      () => ChallengesPage(),
      binding: ChallengesBinding(),
    );
  }

  void _loadCategories() {
    _satorioRepository
        .showsCategoryList(page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<ShowCategory> categories) {
      categories.forEach(
        (category) {
          _satorioRepository
              .showsFromCategory(category.id)
              .then((List<Show> shows) {
            final ShowCategory showCategory = ShowCategory(category.id,
                category.title, category.disabled, category.sort, shows);
            categoriesRx.update((value) {
              final index =
                  value!.indexWhere((element) => element.id == showCategory.id);
              if (index >= 0) {
                value.removeAt(index);
                value.insert(index, showCategory);
                _sortShows(value);
              } else {
                value.add(showCategory);
                _sortShows(value);
              }
            });
          });
        },
      );
    });
  }

  void _sortShows(List<ShowCategory> shows) {
    shows.sort((a, b) => a.sort.compareTo(b.sort));
  }

  void _loadAllShows() {
    _satorioRepository
        .shows(null, page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      allShowsRx.value = shows;
    });
  }

  void toShowsCategory(ShowCategory showCategory) {
    Get.to(
      () => ShowsCategoryPage(),
      binding: ShowsCategoryBinding(),
      arguments: ShowsCategoryArgument(
          showCategory.id, showCategory.title, ShowsType.HomeAllShows),
    );
  }

  void toAllShows() {
    Get.to(
      () => ShowsCategoryPage(),
      binding: ShowsCategoryBinding(),
      arguments: ShowsCategoryArgument(
          'all', 'txt_all_realms'.tr, ShowsType.HomeAllShows),
    );
  }

  void toShowDetail(Show show) {
    Get.to(
      () => ShowDetailWithEpisodesPage(),
      binding: ShowDetailWithEpisodesBinding(),
      arguments: ShowDetailWithEpisodesArgument(show),
    );
  }

  void toShowNfts(String showId) {
    Get.to(
      () => NftListPage(),
      binding: NftListBinding(),
      arguments: NftListArgument(NftFilterType.Show, showId),
    );
  }

  void toNftItem(final NftItem nftItem) {
    Get.to(
      () => NftItemPage(),
      binding: NftItemBinding(),
      arguments: NftItemArgument(nftItem),
    );
  }

  void toNfts() {
    if (Get.isRegistered<NftCategoriesController>()) {
      NftCategoriesController nftCategoriesController = Get.find();
      nftCategoriesController.refreshData();
    }

    _toTab(MainController.TabNfts);
  }

  void toWallet() {
    _toTab(MainController.TabWallet);
  }

  void toProfile() {
    _toTab(MainController.TabProfile);
  }

  void toBlog() {
    Get.to(
      () => RssListPage(),
      binding: RssListBinding(),
    );
  }

  void toRssItem() {
    if (rssItemRx.value != null) {
      Get.to(
        () => RssItemPage(),
        binding: RssItemBinding(),
        arguments: RssItemArgument(rssItemRx.value!),
      );
    }
  }

  void _toTab(int mainPageTab) {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = mainPageTab;
    }
  }

  void _profileListener() {
    if (_profileListenable.value.length > 0)
      profileRx.value = _profileListenable.value.getAt(0);
  }

  void _saoWalletsListener() {
    saoWalletRx.value = _saoWalletsListenable.value.values.toList();
  }

  void _rssItemsListener() {
    final rssItems = _rssItemsListenable.value.values.toList();
    rssItems.sort((a, b) {
      if (a.pubDate == null)
        return -1;
      else if (b.pubDate == null)
        return 1;
      else
        return b.pubDate!.compareTo(a.pubDate!);
    });
    rssItemRx.value = rssItems.isNotEmpty ? rssItems.first : null;
  }
}

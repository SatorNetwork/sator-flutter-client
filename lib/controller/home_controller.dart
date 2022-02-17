import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/binding/shows_category_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_category.dart';
import 'package:satorio/domain/entities/shows_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';
import 'package:satorio/ui/page_widget/shows_category_page.dart';

class HomeController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<AmountCurrency>> walletRx = Rx([]);

  late final Rx<List<NftItem>> nftHomeRx = Rx([]);
  final Rx<List<Show>> allShowsRx = Rx([]);
  final Rx<List<ShowCategory>> categoriesRx = Rx([]);

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  late ValueListenable<Box<Profile>> profileListenable;
  late ValueListenable<Box<AmountCurrency>> walletBalanceListenable;

  HomeController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    this.walletBalanceListenable = _satorioRepository.walletBalanceListenable()
        as ValueListenable<Box<AmountCurrency>>;
    _satorioRepository
        .nftsFiltered(
      page: _initialPage,
      itemsPerPage: _itemsPerPage,
    )
        .then((value) {
      nftHomeRx.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    _loadAllShows();
    _loadCategories();

    _profileListener();
    profileListenable.addListener(_profileListener);

    _walletBalanceListener();
    walletBalanceListenable.addListener(_walletBalanceListener);
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    walletBalanceListenable.removeListener(_walletBalanceListener);
    super.onClose();
  }

  void refreshHomePage() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.loadNftHome();
    }

    _satorioRepository.updateProfile();
    _satorioRepository.updateWalletBalance();

    _loadCategories();
    _loadAllShows();
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
    _toTab(MainController.TabNfts);
  }

  void toWallet() {
    _toTab(MainController.TabWallet);
  }

  void toProfile() {
    _toTab(MainController.TabProfile);
  }

  void _toTab(int mainPageTab) {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = mainPageTab;
    }
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }

  void _walletBalanceListener() {
    walletRx.value = walletBalanceListenable.value.values.toList();
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/binding/shows_category_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/domain/show_category.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';
import 'package:satorio/ui/page_widget/shows_category_page.dart';

class HomeController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<AmountCurrency>> walletRx = Rx([]);

  late final Rx<NftHome?> nftHomeRx;
  final Rx<List<Show>> showsHighestRewardingRx = Rx([]);
  final Rx<List<Show>> showsPopularMoviesRx = Rx([]);
  final Rx<List<Show>> showsMusicRealmsRx = Rx([]);
  final Rx<List<Show>> showsMostSocializingRx = Rx([]);
  final Rx<List<Show>> showsNewestAddedRx = Rx([]);
  final Rx<List<Show>> allShowsRx = Rx([]);

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  late ValueListenable<Box<Profile>> profileListenable;
  late ValueListenable<Box<AmountCurrency>> walletBalanceListenable;

  HomeController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    this.walletBalanceListenable = _satorioRepository.walletBalanceListenable()
        as ValueListenable<Box<AmountCurrency>>;

    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      nftHomeRx = mainController.nftHomeRx;
    } else {
      nftHomeRx = Rx(null);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadAllShows();
    _loadShowByCategoryName();

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
    _loadAllShows();
    _loadShowByCategoryName();
  }

  void _loadAllShows() {
    _satorioRepository
        .shows(page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      allShowsRx.value = shows;
    });
  }

  void _loadShowByCategoryName() {
    _satorioRepository
        .showsFromCategory(ShowCategory.highestRewarding)
        .then((List<Show> shows) {
      showsHighestRewardingRx.value = shows;
    });

    _satorioRepository
        .showsFromCategory(ShowCategory.mostSocializing)
        .then((List<Show> shows) {
      showsMostSocializingRx.value = shows;
    });

    _satorioRepository
        .showsFromCategory(ShowCategory.newestAdded)
        .then((List<Show> shows) {
      showsNewestAddedRx.value = shows;
    });

    _satorioRepository
        .showsFromCategory(ShowCategory.popularMovies)
        .then((List<Show> shows) {
      showsPopularMoviesRx.value = shows;
    });

    _satorioRepository
        .showsFromCategory(ShowCategory.musicRealms)
        .then((List<Show> shows) {
      showsMusicRealmsRx.value = shows;
    });
  }

  void toShowsCategory(String categoryName) {
    Get.to(
      () => ShowsCategoryPage(),
      binding: ShowsCategoryBinding(),
      arguments: ShowsCategoryArgument(categoryName),
    );
  }

  void toShowDetail(Show show) {
    Get.to(
      () => ShowDetailWithEpisodesPage(),
      binding: ShowDetailWithEpisodesBinding(),
      arguments: ShowDetailWithEpisodesArgument(show),
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

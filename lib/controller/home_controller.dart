import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/binding/show_detail_binding.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/binding/shows_category_binding.dart';
import 'package:satorio/controller/show_challenges_controller.dart';
import 'package:satorio/controller/show_detail_controller.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';
import 'package:satorio/ui/page_widget/show_detail_page.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';
import 'package:satorio/ui/page_widget/shows_category_page.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<AmountCurrency>> walletRx = Rx([]);

  final Rx<List<Show>> showsHighestRewardingRx = Rx([]);
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
  }

  @override
  void onInit() {
    super.onInit();
    _loadAllShows();
    _loadShowByCategoryName();

    profileListenable.addListener(_profileListener);
    walletBalanceListenable.addListener(_walletBalanceListener);
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    walletBalanceListenable.removeListener(_walletBalanceListener);
    super.onClose();
  }

  void refreshHomePage() {
    _satorioRepository.updateProfile();
    _satorioRepository.updateWalletBalance();
    _loadAllShows();
    _loadShowByCategoryName();
  }

  void _loadAllShows() {
    _satorioRepository.shows(page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      allShowsRx.value = shows;
    });
  }

  void _loadShowByCategoryName() {
    _satorioRepository
        .showsFromCategory('highest_rewarding')
        .then((List<Show> shows) {
      showsHighestRewardingRx.value = shows;
    });

    _satorioRepository
        .showsFromCategory('most_socializing')
        .then((List<Show> shows) {
      showsMostSocializingRx.value = shows;
    });

    _satorioRepository
        .showsFromCategory('newest_added')
        .then((List<Show> shows) {
      showsNewestAddedRx.value = shows;
    });
  }

  void toShowsCategory(String categoryName) {
    Get.to(
          () => ShowsCategoryPage(),
      binding: ShowsCategoryBinding(),
      arguments: ShowsCategoryArgument(categoryName),
    );
  }

  void toShowChallenges(Show show) {
    Get.to(
      () => ShowChallengesPage(),
      binding: ShowChallengesBinding(),
      arguments: ShowChallengesArgument(show),
    );
  }

  void toShowDetail(Show show) {
    // Get.to(
    //   () => ShowDetailPage(),
    //   binding: ShowDetailBinding(),
    //   arguments: ShowDetailArgument(show),
    // );
    Get.to(
          () => ShowDetailWithEpisodesPage(),
      binding: ShowDetailWithEpisodesBinding(),
      arguments: ShowDetailWithEpisodesArgument(show),
    );
  }

  void toLogoutDialog() {
    Get.dialog(
      DefaultDialog(
        'txt_log_out'.tr,
        'txt_log_out_message'.tr,
        'txt_yes'.tr,
        icon: Icons.logout,
        onPressed: () {
          _satorioRepository.logout();
        },
      ),
    );
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }

  void _walletBalanceListener() {
    walletRx.value = walletBalanceListenable.value.values.toList();
  }
}

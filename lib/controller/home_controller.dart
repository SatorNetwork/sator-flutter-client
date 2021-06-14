import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/domain/entities/amount_currency.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile> profileRx = Rx(null);
  final Rx<List<AmountCurrency>> walletRx = Rx([]);
  final Rx<List<Show>> showsRx = Rx([]);

  ValueListenable<Box<Profile>> profileListenable;
  ValueListenable<Box<AmountCurrency>> walletListenable;

  HomeController() {
    this.tabController = TabController(length: 2, vsync: this);
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    this.walletListenable = _satorioRepository.walletListenable()
        as ValueListenable<Box<AmountCurrency>>;
  }

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWallet();
    _loadShows();

    profileListenable.addListener(_profileListener);
    walletListenable.addListener(_walletListener);
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    walletListenable.removeListener(_walletListener);
    super.onClose();
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWallet() {
    _satorioRepository.updateWallet();
  }

  void _loadShows() {
    _satorioRepository.shows().then((List<Show> shows) {
      showsRx.value = shows;
    });
  }

  void toShows() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = 1;
    }
  }

  void toShowChallenges(Show show) {
    Get.to(() => ShowChallengesPage(show), binding: ShowChallengesBinding());
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
    profileRx.value = profileListenable.value.getAt(0);
  }

  void _walletListener() {
    walletRx.value = walletListenable.value.values.toList();
  }
}

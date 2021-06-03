import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile> profileRx = Rx(null);
  final Rx<WalletBalance> walletBalanceRx = Rx(null);
  final Rx<List<Show>> showsRx = Rx([]);

  HomeController() {
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWalletBalance();
    _loadShows();
  }

  void _loadProfile() {
    _satorioRepository.profile().then((Profile profile) {
      profileRx.value = profile;
    });
  }

  void _loadWalletBalance() {
    _satorioRepository.walletBalance().then((WalletBalance walletBalance) {
      walletBalanceRx.value = walletBalance;
    });
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
}

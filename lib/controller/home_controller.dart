import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/wallet_balance.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

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
      print('${shows.length}');
      showsRx.value = shows;
    });
  }
}

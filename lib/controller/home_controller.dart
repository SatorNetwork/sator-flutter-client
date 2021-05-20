import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile> profileRx = Rx(null);

  HomeController() {
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onInit() {
    _satorioRepository.profile().then((Profile profile) {
      profileRx.value = profile;
    });
  }
}

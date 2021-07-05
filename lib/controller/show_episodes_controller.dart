import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowEpisodesController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;

  ShowEpisodesController() {
    tabController = TabController(length: 2, vsync: this);
  }

  back() {
    Get.back();
  }
}

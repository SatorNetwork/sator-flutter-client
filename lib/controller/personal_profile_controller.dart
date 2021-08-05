import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalProfileController extends GetxController
    with SingleGetTickerProviderMixin {
  late final TabController tabController;

  PersonalProfileController() {
    tabController = TabController(length: 3, vsync: this);
  }

  void toSettings() {}

  void toNotificationSettings() {}
}

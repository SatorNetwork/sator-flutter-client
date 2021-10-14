import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';

class PersonalProfileController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  late final TabController tabController;

  PersonalProfileController() {
    tabController = TabController(length: 3, vsync: this);
  }

  void toSettings() {
    toNonWorkingFeatureDialog();
  }

  void toNotificationSettings() {
    toNonWorkingFeatureDialog();
  }
}

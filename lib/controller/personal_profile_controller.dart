import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/settings_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/ui/page_widget/settings_page.dart';

class PersonalProfileController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  late final TabController tabController;

  PersonalProfileController() {
    tabController = TabController(length: 3, vsync: this);
  }

  void toSettings() {
    Get.to(
      () => SettingsPage(),
      binding: SettingsBinding(),
    );
  }

  void toNotificationSettings() {
    toNonWorkingFeatureDialog();
  }
}

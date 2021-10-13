import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_item_detail_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_detail_controller.dart';
import 'package:satorio/ui/page_widget/nft_item_detail_page.dart';

class PersonalProfileController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  late final TabController tabController;

  PersonalProfileController() {
    tabController = TabController(length: 3, vsync: this);
  }

  void toSettings() {
    toNonWorkingFeatureDialog();
    // Get.to(
    //   () => NftItemDetailPage(),
    //   binding: NftItemDetailBinding(),
    //   arguments: NftItemDetailArgument(),
    // );
  }

  void toNotificationSettings() {
    toNonWorkingFeatureDialog();
  }
}

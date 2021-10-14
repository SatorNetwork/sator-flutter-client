import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_item_detail_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_detail_controller.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_detail_page.dart';

class NFTsController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final TabController tabController;
  final List<String> tabTitles = [
    'txt_popular'.tr,
    'txt_new'.tr,
    'txt_shows'.tr,
    'txt_sport'.tr,
  ];

  NFTsController() {
    tabController = TabController(length: tabTitles.length, vsync: this);
  }

  void toItemDetail() {
    Get.to(
      () => NftItemDetailPage(),
      binding: NftItemDetailBinding(),
      arguments: NftItemDetailArgument(),
    );
  }
}

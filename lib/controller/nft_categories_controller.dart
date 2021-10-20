import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';

class NftCategoriesController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late TabController tabController;

  final Rx<List<NftCategory>> categoriesRx = Rx([]);
  final Rx<Map<String, List<NftItem>>> itemsRx = Rx({});

  NftCategoriesController() {
    NftCategoriesArgument argument = Get.arguments as NftCategoriesArgument;

    tabController = TabController(length: 0, vsync: this);

    _loadNftCategories(toCategoryId: argument.nftCategoryId);
  }

  void refreshData() {
    _loadNftCategories();
  }

  void _loadNftCategories({String? toCategoryId}) {
    _satorioRepository.nftCategories().then((List<NftCategory> categories) {
      tabController = TabController(length: categories.length, vsync: this);
      categoriesRx.value = categories;

      categories.forEach((category) {
        _loadItemsByCategory(category);
      });

      if (toCategoryId != null) {
        int tab = categories.indexWhere(
          (element) => element.id == toCategoryId,
        );
        tabController.animateTo(tab);
      }
    });
  }

  void _loadItemsByCategory(final NftCategory category) {
    _satorioRepository
        .nftItemsByCategory(category.id)
        .then((List<NftItem> items) {
      itemsRx.update((value) {
        if (value != null) value[category.id] = items;
      });
    });
  }

  void toNftItem(final NftItem nftItem) {
    Get.to(
      () => NftItemPage(),
      binding: NftItemBinding(),
      arguments: NftItemArgument(nftItem),
    );
  }
}

class NftCategoriesArgument {
  final String? nftCategoryId;

  const NftCategoriesArgument(this.nftCategoryId);
}

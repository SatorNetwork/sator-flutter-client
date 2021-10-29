import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';

class NftCategoriesController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  static const int _fixedTabLength = 1;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final SatorioRepository _satorioRepository = Get.find();

  late TabController tabController;

  late final Rx<NftHome?> nftHomeRx;
  final Rx<List<NftCategory>> categoriesRx = Rx([]);

  final Rx<Map<String, List<NftItem>>> itemsRx = Rx({});
  final Rx<Map<String, int>> _pageRx = Rx({});
  final Rx<Map<String, bool>> _isLoadingRx = Rx({});
  final Rx<Map<String, bool>> _isAllLoadedRx = Rx({});

  NftCategoriesController() {
    tabController = TabController(length: _fixedTabLength, vsync: this);

    _loadNftCategories();
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      nftHomeRx = mainController.nftHomeRx;
    } else {
      nftHomeRx = Rx(null);
    }
  }

  void refreshData() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.loadNftHome();
    }
    _loadNftCategories();
  }

  void toNftItem(final NftItem nftItem) {
    Get.to(
      () => NftItemPage(),
      binding: NftItemBinding(),
      arguments: NftItemArgument(nftItem),
    );
  }

  void toNftCategory(String categoryId) {
    int categoryIndex = categoriesRx.value.indexWhere(
      (element) => element.id == categoryId,
    );
    if (categoryIndex >= 0) {
      tabController.animateTo(categoryIndex + _fixedTabLength);
    }
  }

  void _loadNftCategories() {
    _satorioRepository.nftCategories().then(
      (List<NftCategory> categories) {
        tabController = TabController(
            length: categories.length + _fixedTabLength, vsync: this);

        categoriesRx.value = categories;

        categories.forEach(
          (category) {
            _pageRx.value[category.id] = _initialPage;
            _isLoadingRx.value[category.id] = false;
            _isAllLoadedRx.value[category.id] = false;
            itemsRx.value[category.id] = [];
            loadItemsByCategory(category);
          },
        );
      },
    );
  }

  void loadItemsByCategory(final NftCategory category) {
    print(_isLoadingRx.value[category.id]!);
    if (_isAllLoadedRx.value[category.id]!) return;

    if (_isLoadingRx.value[category.id]!) return;

    Future.value(true)
        .then((value) {
          _isLoadingRx.value[category.id] = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.nftItems(
            NftFilterType.NftCategory,
            category.id,
            page: _pageRx.value[category.id],
            itemsPerPage: _itemsPerPage,
          ),
        )
        .then(
          (List<NftItem> items) {
            itemsRx.update((value) {
              value![category.id]!.addAll(items);
            });
            _isAllLoadedRx.value[category.id] = items.isEmpty;
            _isLoadingRx.value[category.id] = false;
            _pageRx.value[category.id] = _pageRx.value[category.id]! + 1;
          },
        )
        .catchError(
          (value) {
            _isLoadingRx.value[category.id] = false;
          },
        );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/shows_category_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/shows_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/domain/show_category.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/shows_category_page.dart';

class NftCategoriesController extends GetxController
    with SingleGetTickerProviderMixin, NonWorkingFeatureMixin {
  static const int _fixedTabLength = 1;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final SatorioRepository _satorioRepository = Get.find();

  late TabController tabController;

  late final Rx<NftHome?> nftHomeRx;
  final Rx<List<NftCategory>> categoriesRx = Rx([]);
  final Rx<List<Show>> allShowsRx = Rx([]);

  final Rx<Map<String, List<NftItem>>> itemsRx = Rx({});

  final Map<String, int> _pageRx = {};
  final Map<String, bool> _isLoadingRx = {};
  final Map<String, bool> _isAllLoadedRx = {};

  NftCategoriesController() {
    tabController = TabController(length: _fixedTabLength, vsync: this);

    _loadShowsWithNfts();

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

  void _loadShowsWithNfts() {
    _satorioRepository
        .shows(true, page: _initialPage, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      allShowsRx.value = shows;
    });
  }

  void toAllShows() {
    Get.to(
      () => ShowsCategoryPage(),
      binding: ShowsCategoryBinding(),
      arguments: ShowsCategoryArgument(ShowCategory.withNfts, ShowsType.NftsAllShows),
    );
  }

  void toShowNfts(String showId) {
      Get.to(
            () => NftListPage(),
        binding: NftListBinding(),
        arguments: NftListArgument(NftFilterType.Show, showId),
      );
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
            _pageRx[category.id] = _initialPage;
            _isLoadingRx[category.id] = false;
            _isAllLoadedRx[category.id] = false;
            itemsRx.value[category.id] = [];
            loadItemsByCategory(category);
          },
        );
      },
    );
  }

  void loadItemsByCategory(final NftCategory category) async {
    if (_isAllLoadedRx[category.id]!) return;
    if (_isLoadingRx[category.id]!) return;

    _isLoadingRx[category.id] = true;

    await _satorioRepository
        .nftItems(
      NftFilterType.NftCategory,
      category.id,
      page: _pageRx[category.id],
      itemsPerPage: _itemsPerPage,
    )
        .then(
      (List<NftItem> items) {
        itemsRx.update((value) {
          value![category.id]!.addAll(items);
        });
        _pageRx[category.id] = _pageRx[category.id]! + 1;
        _isAllLoadedRx[category.id] = items.isEmpty;
        _isLoadingRx[category.id] = false;
      },
    ).catchError(
      (value) {
        _isLoadingRx[category.id] = false;
      },
    );
  }
}

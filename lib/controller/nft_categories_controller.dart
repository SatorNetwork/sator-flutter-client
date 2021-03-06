import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/shows_category_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/shows_category_controller.dart';
import 'package:satorio/domain/entities/nft_category.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/nft_order_type.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_category_type.dart';
import 'package:satorio/domain/entities/shows_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/shows_category_page.dart';

class NftCategoriesController extends GetxController
    with GetTickerProviderStateMixin, NonWorkingFeatureMixin {
  static const int _fixedTabLength = 2;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final SatorioRepository _satorioRepository = Get.find();

  late TabController tabController;

  late final Rx<NftHome?> nftHomeRx = Rx(null);
  final Rx<List<NftCategory>> categoriesRx = Rx([]);
  final Rx<List<NftItem>> allNftsRx = Rx([]);
  final Rx<List<Show>> allShowsRx = Rx([]);

  final Rx<Map<String, List<NftItem>>> itemsRx = Rx({});

  final Map<String, int> _pageRx = {};
  final Map<String, bool> _isLoadingRx = {};
  final Map<String, bool> _isAllLoadedRx = {};

  final RxInt _nftsPageRx = _initialPage.obs;
  final RxBool _isLoadRx = false.obs;
  final RxBool _isLoadedRx = false.obs;

  List<IAPItem> products = [];

  NftCategoriesController() {
    tabController = TabController(length: _fixedTabLength, vsync: this);

    _loadShowsWithNfts();

    _getInAppProducts();

    loadNfts();

    //TODO: uncomment with categories
    // _loadNftCategories();
    // if (Get.isRegistered<MainController>()) {
    //   MainController mainController = Get.find();
    //   allNftsRx.value = mainController.nftHomeRx.value;
    // } else {
    //   nftHomeRx.value = null;
    // }
  }

  void refreshData() {
    _getInAppProducts();
    _satorioRepository.nftsFiltered(
        orderType: NftOrderOnSaleType.onSale
    ).then((value) {
      allNftsRx.value = value;
    });
  }

  void _getInAppProducts() {
    _satorioRepository.inAppProductsIds().then((ids) {
      if (ids == null) return;

      _satorioRepository.getProducts(ids).then((value) {
        products = value;

        products.sort((a, b) => double.parse(a.price!).compareTo(double.parse(b.price!)));
      });
    });
  }

  String setItemPrice(double price) {
    String itemPrice = '';
    for (int i =0; i < products.length; i++) {
      double inAppPrice = double.parse(products[i].price!);

      if (price <= inAppPrice) {
        itemPrice = inAppPrice.toString();
        break;
      }
    }

    return itemPrice;
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
      arguments: ShowsCategoryArgument(
          ShowCategoryType.withNfts, null, ShowsType.NftsAllShows),
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

  void toAllTab() {
    tabController.animateTo(1);
  }

  void toNftCategory(String categoryId) {
    int categoryIndex = categoriesRx.value.indexWhere(
      (element) => element.id == categoryId,
    );
    if (categoryIndex >= 0) {
      tabController.animateTo(categoryIndex + _fixedTabLength);
    }
  }

  void loadNfts() {
    if (_isLoadedRx.value) return;

    if (_isLoadRx.value) return;

    Future.value(true)
        .then((value) {
          _isLoadRx.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.nftsFiltered(
              page: _nftsPageRx.value,
              itemsPerPage: _itemsPerPage,
              orderType: NftOrderOnSaleType.onSale),
        )
        .then(
          (List<NftItem> nftItems) {
            allNftsRx.update((value) {
              if (value != null) value.addAll(nftItems);
            });
            _isLoadedRx.value = nftItems.isEmpty;
            _isLoadRx.value = false;
            _nftsPageRx.value = _nftsPageRx.value + 1;
          },
        )
        .catchError(
          (value) {
            _isLoadRx.value = false;
          },
        );
  }

  void _loadNftCategories() {
    _satorioRepository.nftCategories().then(
      (List<NftCategory> categories) {
        tabController = TabController(
            //TODO: categories.length +
            length: _fixedTabLength,
            vsync: this);

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

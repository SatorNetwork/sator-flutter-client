import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/nft_order_type.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/util/extension.dart';

import 'nft_item_controller.dart';

class NftListController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final String _objectId;
  late final NftFilterType _filterType;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  final RxString titleRx = ''.obs;
  final Rx<List<NftItem>> nftItemsRx = Rx([]);

  NftListController() {
    NftListArgument argument = Get.arguments as NftListArgument;
    _filterType = argument.filterType;
    _objectId = argument.objectId;

    loadNfts();
    _updateTitle();
  }

  void back() {
    if (_filterType == NftFilterType.User) {
      _toProfile();
      return;
    }

    Get.back();
  }

  void _toProfile() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = MainController.TabProfile;
      backToMain();
    }

    if (Get.isRegistered<ProfileController>()) {
      ProfileController profileController = Get.find();
      profileController.refreshPage();
    }
  }

  void toNftItem(final NftItem nftItem) {
    Get.to(
      () => NftItemPage(),
      binding: NftItemBinding(),
      arguments: NftItemArgument(nftItem),
    );
  }

  void loadNfts() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    Future.value(true)
        .then((value) {
          _isLoadingRx.value = true;
          return value;
        })
        .then((value) => _loadNftsByType())
        .then(
          (List<NftItem> nftItems) {
            nftItemsRx.update((value) {
              if (value != null) value.addAll(nftItems);
            });
            _isAllLoadedRx.value = nftItems.isEmpty;
            _isLoadingRx.value = false;
            _pageRx.value = _pageRx.value + 1;
          },
        )
        .catchError(
          (value) {
            _isLoadingRx.value = false;
          },
        );
  }

  Future<List<NftItem>> _loadNftsByType() {
    switch (_filterType) {
      case NftFilterType.Show:
        return _loadShowNfts();
      case NftFilterType.User:
        return _loadUserNfts();
      default:
        return _loadShowNfts();
    }
  }

  Future<List<NftItem>> _loadUserNfts() {
    return _satorioRepository.nftsFiltered(
        page: _initialPage,
        itemsPerPage: _itemsPerPage,
        owner: _objectId);
  }

  Future<List<NftItem>> _loadShowNfts() {
    return _satorioRepository.nftsFiltered(
        page: _initialPage,
        itemsPerPage: _itemsPerPage,
        orderType: NftOrderOnSaleType.onSale,
        showIds: [_objectId]);
  }

  void _updateTitle() {
    switch (_filterType) {
      case NftFilterType.NftCategory:
        titleRx.value = 'Category NFTs';
        break;
      case NftFilterType.Show:
        titleRx.value = 'Show NFTs';
        break;
      case NftFilterType.Episode:
        titleRx.value = 'ShowEpisode NFTs';
        break;
      case NftFilterType.User:
        Profile? profile = (_satorioRepository.profileListenable()
                as ValueListenable<Box<Profile>>)
            .value
            .getAt(0);
        if (profile != null) {
          titleRx.value = _objectId == profile.id
              ? 'txt_my_nfts'.tr
              : 'txt_not_my_nfts'.tr.format([profile.username]);
        }
        break;
    }
  }
}

class NftListArgument {
  final NftFilterType filterType;
  final String objectId;

  const NftListArgument(this.filterType, this.objectId);
}

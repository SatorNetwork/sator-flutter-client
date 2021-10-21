import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/util/extension.dart';

import 'nft_item_controller.dart';

class NftByUserController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final String _userId;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  final RxString titleRx = ''.obs;
  final Rx<List<NftItem>> nftItemsRx = Rx([]);

  NftByUserController() {
    NftByUserArgument argument = Get.arguments as NftByUserArgument;
    _userId = argument.usedId;

    loadNfts();
    _updateTitle();
  }

  void back() {
    Get.back();
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

    _isLoadingRx.value = true;

    _satorioRepository
        .nftByUser(
      _userId,
      page: _pageRx.value,
      itemsPerPage: _itemsPerPage,
    )
        .then((List<NftItem> nftItems) {
      nftItemsRx.update((value) {
        if (value != null) value.addAll(nftItems);
      });
      _isAllLoadedRx.value = nftItems.isEmpty;
      _isLoadingRx.value = false;
      _pageRx.value = _pageRx.value + 1;
    }).catchError((value) {
      _isLoadingRx.value = false;
    });
  }

  void _updateTitle() {
    Profile? profile = (_satorioRepository.profileListenable()
            as ValueListenable<Box<Profile>>)
        .value
        .getAt(0);
    if (profile != null) {
      titleRx.value = _userId == profile.id
          ? 'txt_my_nfts'.tr
          : 'txt_not_my_nfts'.tr.format([profile.username]);
    }
  }
}

class NftByUserArgument {
  final String usedId;

  const NftByUserArgument(this.usedId);
}

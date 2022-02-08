import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';

import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

import '../util/avatar_list.dart';

class SelectAvatarController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<String?> avatarRx = Rx(null);
  final Rx<Profile?> profileRx = Rx(null);
  final Rx<List<NftItem>> nftItemsRx = Rx([]);
  final Rx<AvatarsListType> avatarsListType = Rx(AvatarsListType.local);

  final int _itemsPerPageNft = 4;
  static const int _initialPage = 1;

  late final ValueListenable<Box<Profile>> profileListenable;

  late final SelectAvatarType type;

  SelectAvatarController() {
    SelectAvatarArgument argument = Get.arguments as SelectAvatarArgument;
    type = argument.selectAvatarType;
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  void toggle(AvatarsListType value) {
    avatarsListType.value = value;
  }

  void setAvatar(int index) {
    if (avatarsListType.value == AvatarsListType.local) {
      avatarRx.value = avatars[index];
    } else {
      avatarRx.value = nftItemsRx.value[index].nftPreview;
    }
  }

  void saveAvatar() {
    _satorioRepository.selectAvatar(avatarRx.value!).then((isSuccess) {
      if (isSuccess) {
        //TODO: for future, when settings page created
        switch (type) {
          case SelectAvatarType.registration:
            Get.offAll(
              () => MainPage(),
              binding: MainBinding(),
            );
            break;
          case SelectAvatarType.settings:
            avatarRx.value = null;
            back();
            break;
        }
        _satorioRepository.updateProfile();
      } else {
        avatarRx.value = null;
      }
    }).catchError((value) {
      avatarRx.value = null;
    });
  }

  void back() {
    Get.back();
  }

  void toNfts() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = MainController.TabNfts;
    }
  }

  @override
  void onInit() {
    super.onInit();

    _profileListener();
    profileListenable.addListener(_profileListener);
    _loadNfts();
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    super.onClose();
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }

  void _loadNfts() {
    if (profileRx.value != null) {
      _satorioRepository
          .nftItems(
        NftFilterType.User,
        profileRx.value!.id,
        page: _initialPage,
        itemsPerPage: _itemsPerPageNft,
      )
          .then((List<NftItem> nftItems) {
        nftItemsRx.value = nftItems;
      });
    }
  }
}

class SelectAvatarArgument {
  final SelectAvatarType selectAvatarType;

  const SelectAvatarArgument(this.selectAvatarType);
}

enum AvatarsListType {
  local,
  nfts,
}

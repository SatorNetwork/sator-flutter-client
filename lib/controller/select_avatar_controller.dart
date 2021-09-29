import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';

import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

import '../util/avatar_list.dart';

class SelectAvatarController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<String?> avatarRx = Rx(null);
  final Rx<Profile?> profileRx = Rx(null);

  late final ValueListenable<Box<Profile>> profileListenable;

  late final SelectAvatarType type;

  SelectAvatarController() {
    SelectAvatarArgument argument = Get.arguments as SelectAvatarArgument;
    type = argument.selectAvatarType;
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  void setAvatar(int index) {
    avatarRx.value = avatars[index];
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
            Get.to(
                  () => MainPage(),
              binding: MainBinding(),
            );
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

  void _toProfile() {
    _toTab(MainController.TabProfile);
  }

  void _toTab(int mainPageTab) {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = mainPageTab;
    }
  }

  @override
  void onInit() {
    super.onInit();

    _profileListener();
    profileListenable.addListener(_profileListener);
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
}

class SelectAvatarArgument {
  final SelectAvatarType selectAvatarType;

  const SelectAvatarArgument(this.selectAvatarType);
}

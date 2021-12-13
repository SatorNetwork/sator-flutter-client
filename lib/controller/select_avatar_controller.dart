import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';

import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';
import 'package:satorio/util/avatar_list.dart';

class SelectAvatarController extends GetxController with BackToMainMixin {
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

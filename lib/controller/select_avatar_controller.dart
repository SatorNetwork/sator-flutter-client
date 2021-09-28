import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/domain/entities/profile.dart';

import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

import '../util/avatar_list.dart';

class SelectAvatarController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<String?> avatarRx = Rx(null);
  final Rx<Profile?> profileRx = Rx(null);

  late final ValueListenable<Box<Profile>> profileListenable;

  SelectAvatarController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  void setAvatar(int index) {
    avatarRx.value = avatars[index];
    print(avatarRx.value);
  }

  void saveAvatar() {
    _satorioRepository.selectAvatar(avatarRx.value!).then((isSuccess) {
      if (isSuccess) {
        Get.offAll(
              () => MainPage(),
          binding: MainBinding(),
        );
      } else {
        avatarRx.value = null;
      }
    }).catchError((value) {
      avatarRx.value = null;
    });
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

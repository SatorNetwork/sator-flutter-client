import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ProfileController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);

  late final ValueListenable<Box<Profile>> profileListenable;

  ProfileController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
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

  void showInvite() {}

  void logout() {
    _satorioRepository.logout();
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }
}

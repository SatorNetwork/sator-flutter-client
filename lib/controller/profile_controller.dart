import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/dialog_widget/send_invite_dialog.dart';

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

  void showInvite() {
    Get.dialog(
      SendInviteDialog(),
    );
  }

  void toLogoutDialog() {
    Get.dialog(
      DefaultDialog(
        'txt_log_out'.tr,
        'txt_log_out_message'.tr,
        'txt_yes'.tr,
        icon: Icons.logout,
        onPressed: () {
          _satorioRepository.logout();
        },
      ),
    );
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }
}

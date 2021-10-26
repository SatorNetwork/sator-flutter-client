import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/select_avatar_binding.dart';
import 'package:satorio/binding/settings_about_binding.dart';
import 'package:satorio/binding/settings_change_info_binding.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/controller/settings_change_info_controller.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/select_avatar_page.dart';
import 'package:satorio/ui/page_widget/settings_about_page.dart';
import 'package:satorio/ui/page_widget/settings_change_info_page.dart';

class SettingsController extends GetxController with NonWorkingFeatureMixin, BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  void toNonWorkingDialog() {
    toNonWorkingFeatureDialog();
  }

  void toSelectAvatar() {
    Get.to(() => SelectAvatarPage(),
        binding: SelectAvatarBinding(),
        arguments: SelectAvatarArgument(SelectAvatarType.settings));
  }

  void toChangeInfo(bool isChangeEmail) {
    Get.to(() => SettingsChangeInfoPage(),
        binding: SettingsChangeInfoBinding(),
        arguments: ChangeInfoArgument(isChangeEmail));
  }

  void toAbout() {
    Get.to(() => SettingsAboutPage(),
        binding: SettingsAboutBinding());
  }

  void back() {
    Get.back();
  }

  void toLogoutDialog() {
    Get.dialog(
      DefaultDialog(
        'txt_log_out'.tr,
        'txt_log_out_message'.tr,
        'txt_yes'.tr,
        icon: Icons.logout,
        onButtonPressed: () {
          _satorioRepository.logout();
        },
        secondaryButtonText: 'txt_no'.tr,
      ),
    );
  }
}
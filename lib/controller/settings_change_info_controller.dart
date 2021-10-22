import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/settings_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/settings_page.dart';

import 'email_verification_controller.dart';
import 'mixin/validation_mixin.dart';

class SettingsChangeInfoController extends GetxController
    with NonWorkingFeatureMixin, ValidationMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final RxString emailRx = ''.obs;
  final RxString usernameRx = ''.obs;
  final RxBool isRequested = false.obs;

  late bool isChangeEmail;

  SettingsChangeInfoController() {
    ChangeInfoArgument argument = Get.arguments as ChangeInfoArgument;

    isChangeEmail = argument.isChangeEmail;
  }

  @override
  void onInit() {
    super.onInit();
    if (isChangeEmail) {
      emailController.addListener(_emailListener);
    } else {
      usernameController.addListener(_usernameListener);
    }
  }

  @override
  void onClose() {
    if (isChangeEmail) {
      emailController.removeListener(_emailListener);
    } else {
      usernameController.removeListener(_usernameListener);
    }
    super.onClose();
  }

  void requestUpdateEmail() {
    Future.value(true)
        .then((value) {
      isRequested.value = true;
      return value;
    }).then((value) {
      _satorioRepository.requestUpdateEmail(emailRx.value).then((isSuccess) {
        if (isSuccess) {
          Get.to(
                () => EmailVerificationPage(),
            binding: EmailVerificationBinding(),
            arguments: EmailVerificationArgument(emailRx.value, true),
          );
          emailController.clear();
        }
        isRequested.value = false;
      }).catchError((error) {
        isRequested.value = false;
        handleValidationException(error);
      });
    });
  }

  void updateUsername() {
    Future.value(true)
        .then((value) {
      isRequested.value = true;
      return value;
    }).then((value) {
      _satorioRepository.updateUsername(usernameRx.value).then((isSuccess) {
        if (isSuccess) {
          _satorioRepository.updateProfile();
          Get.to(
                () => SettingsPage(),
            binding: SettingsBinding(),
          );
          usernameController.clear();
        }
        isRequested.value = false;
      }).catchError((error) {
        isRequested.value = false;
        handleValidationException(error);
      });
    });
  }

  void _emailListener() {
    emailRx.value = emailController.text;
  }

  void _usernameListener() {
    usernameRx.value = usernameController.text;
  }

  void toNonWorkingDialog() {
    toNonWorkingFeatureDialog();
  }

  void back() {
    Get.back();
  }
}

//TODO: refactor with enum types
class ChangeInfoArgument {
  final bool isChangeEmail;

  const ChangeInfoArgument(this.isChangeEmail);
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/domain/entities/change_info_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';

import 'email_verification_controller.dart';
import 'mixin/validation_mixin.dart';

class SettingsChangeInfoController extends GetxController with ValidationMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final RxString emailRx = ''.obs;
  final RxString usernameRx = ''.obs;
  final RxString oldPasswordRx = ''.obs;
  final RxString newPasswordRx = ''.obs;

  final RxBool oldPasswordObscured = true.obs;
  final RxBool newPasswordObscured = true.obs;
  final RxBool isRequested = false.obs;

  late ChangeInfoType type;

  SettingsChangeInfoController() {
    ChangeInfoArgument argument = Get.arguments as ChangeInfoArgument;

    type = argument.changeInfoType;
  }

  @override
  void onInit() {
    super.onInit();
    switch (type) {
      case ChangeInfoType.email:
        emailController.addListener(_emailListener);
        break;
      case ChangeInfoType.username:
        usernameController.addListener(_usernameListener);
        break;
      case ChangeInfoType.password:
        oldPasswordController.addListener(_oldPasswordListener);
        newPasswordController.addListener(_newPasswordListener);
        break;
    }
  }

  @override
  void onClose() {
    switch (type) {
      case ChangeInfoType.email:
        emailController.removeListener(_emailListener);
        break;
      case ChangeInfoType.username:
        usernameController.removeListener(_usernameListener);
        break;
      case ChangeInfoType.password:
        oldPasswordController.removeListener(_oldPasswordListener);
        newPasswordController.removeListener(_newPasswordListener);
        break;
    }
    super.onClose();
  }

  void requestUpdateEmail() {
    Future.value(true).then((value) {
      isRequested.value = true;
      return value;
    }).then((value) {
      _satorioRepository.requestUpdateEmail(emailRx.value).then((isSuccess) {
        if (isSuccess) {
          Get.off(
            () => EmailVerificationPage(),
            binding: EmailVerificationBinding(),
            arguments: EmailVerificationArgument(
              emailRx.value,
              isUpdate: true,
            ),
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
    Future.value(true).then((value) {
      isRequested.value = true;
      return value;
    }).then((value) {
      _satorioRepository.updateUsername(usernameRx.value).then((isSuccess) {
        if (isSuccess) {
          _satorioRepository.isTokenValid().then((value) {
            _satorioRepository.updateProfile().then((value) {
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: Text('txt_username_change_success'.tr),
                ),
              );
              Future.delayed(
                Duration(seconds: 2),
                () {
                  Get.back();
                },
              );
              usernameController.clear();
              isRequested.value = false;
            });
          });
        }
      }).catchError((error) {
        isRequested.value = false;
        handleValidationException(error);
      });
    });
  }

  void changePassword() {
    Future.value(true).then((value) {
      isRequested.value = true;
      return value;
    }).then((value) {
      _satorioRepository
          .changePassword(oldPasswordRx.value, newPasswordRx.value)
          .then((isSuccess) {
        if (isSuccess) {
          _clearPasswordController();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('txt_password_change_success'.tr),
            ),
          );
          Future.delayed(
            Duration(seconds: 2),
            () {
              Get.back();
            },
          );
        }
        isRequested.value = false;
      }).catchError((error) {
        isRequested.value = false;
        handleValidationException(error);
      });
    });
  }

  void _clearPasswordController() {
    oldPasswordController.clear();
    newPasswordController.clear();
  }

  void _emailListener() {
    emailRx.value = emailController.text;
  }

  void _usernameListener() {
    usernameRx.value = usernameController.text;
  }

  void _oldPasswordListener() {
    oldPasswordRx.value = oldPasswordController.text;
  }

  void _newPasswordListener() {
    newPasswordRx.value = newPasswordController.text;
  }

  void back() {
    Get.back();
  }
}

class ChangeInfoArgument {
  final ChangeInfoType changeInfoType;

  const ChangeInfoArgument(this.changeInfoType);
}

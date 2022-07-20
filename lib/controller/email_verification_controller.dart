import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/select_avatar_binding.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/select_avatar_page.dart';

class EmailVerificationController extends GetxController with ValidationMixin {
  static const Duration _defaultDelay = Duration(minutes: 1);

  final TextEditingController codeController = TextEditingController();

  final SatorioRepository _satorioRepository = Get.find();
  final RxInt delayRx = 0.obs;
  Timer? _delayTimer;

  late final String email;
  late final bool isUpdate;
  late final bool showAnotherAccountLogin;
  late final Uri? deepLink;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _delayTimer?.cancel();
    _delayTimer = null;
    super.onClose();
  }

  void back() {
    Get.back();
  }

  EmailVerificationController() {
    EmailVerificationArgument argument = Get.arguments;

    email = argument.email;
    isUpdate = argument.isUpdate;
    showAnotherAccountLogin = argument.showAnotherAccountLogin;
    deepLink = argument.deepLink;
  }

  void verify() {
    isUpdate ? _verifyUpdateEmail() : _verifyAccount();
  }

  void _verifyAccount() {
    _satorioRepository.verifyAccount(codeController.text).then(
      (isSuccess) {
        if (isSuccess) {
          HapticFeedback.vibrate();
          Get.offAll(
            () => SelectAvatarPage(),
            binding: SelectAvatarBinding(),
            arguments: SelectAvatarArgument(
              SelectAvatarType.registration,
              deepLink,
            ),
          );
        } else {
          codeController.clear();
        }
      },
    ).catchError((value) {
      codeController.clear();
      handleValidationException(value);
    });
  }

  void _verifyUpdateEmail() {
    _satorioRepository.verifyUpdateEmail(email, codeController.text).then(
      (isSuccess) {
        if (isSuccess) {
          _satorioRepository.updateProfile();
          Get.back();
          codeController.clear();
        } else {
          codeController.clear();
        }
      },
    ).catchError((value) {
      codeController.clear();
      handleValidationException(value);
    });
  }

  void resendCode() {
    _satorioRepository.resendCode().then(
      (isSuccess) {
        if (isSuccess) {
          codeController.clear();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('txt_code_resend_success'.tr),
            ),
          );
          _startTimer();
        }
      },
    );
  }

  void loginViaAnotherAccount() {
    _satorioRepository.logout();
  }

  void _startTimer() {
    _delayTimer?.cancel();
    _delayTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick >= _defaultDelay.inSeconds) _delayTimer?.cancel();
      delayRx.value = _defaultDelay.inSeconds - timer.tick;
    });
  }
}

class EmailVerificationArgument {
  final String email;
  final bool isUpdate;
  final bool showAnotherAccountLogin;
  final Uri? deepLink;

  const EmailVerificationArgument(
    this.email, {
    this.showAnotherAccountLogin = false,
    this.isUpdate = false,
    this.deepLink,
  });
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    deepLink = argument.deepLink;
  }

  void verifyAccount() {
    _satorioRepository.verifyAccount(codeController.text).then(
      (isSuccess) {
        if (isSuccess) {
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

  void verifyUpdateEmail() {
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
  final Uri? deepLink;

  const EmailVerificationArgument(this.email, this.isUpdate, this.deepLink);
}

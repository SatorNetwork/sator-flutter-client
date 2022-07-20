import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class DeleteAccountVerificationController extends GetxController
    with ValidationMixin {
  static const Duration _defaultDelay = Duration(minutes: 1);

  final TextEditingController codeController = TextEditingController();

  final SatorioRepository _satorioRepository = Get.find();
  final RxInt delayRx = 0.obs;
  Timer? _delayTimer;

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

  void verify() {
    final String code = codeController.text;

    _satorioRepository.validateDeleteAccountCode(code).then(
      (isSuccess) {
        if (isSuccess) {
          Get.dialog(
            DefaultDialog(
              'txt_delete_account'.tr,
              'txt_delete_account_confirm'.tr,
              'txt_confirm'.tr,
              icon: Icons.delete_forever_rounded,
              onButtonPressed: () {
                _deleteAccount(code);
              },
              secondaryButtonText: 'txt_no'.tr,
              onSecondaryButtonPressed: () {
                back();
              },
            ),
          );
        } else {
          codeController.clear();
        }
      },
    );
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

  void _deleteAccount(String code) {
    _satorioRepository.deleteAccount(code);
  }
}

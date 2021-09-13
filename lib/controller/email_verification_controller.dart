import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class EmailVerificationController extends GetxController with ValidationMixin {
  final TextEditingController codeController = TextEditingController();

  final SatorioRepository _satorioRepository = Get.find();

  late String email = '';

  void back() {
    Get.back();
  }

  EmailVerificationController() {
    EmailVerificationArgument argument = Get.arguments;

    email = argument.email!;
  }

  void verifyAccount() {
    _satorioRepository.verifyAccount(codeController.text).then(
      (isSuccess) {
        if (isSuccess) {
          Get.offAll(() => MainPage(), binding: MainBinding());
        } else {
          codeController.clear();
        }
      },
    ).catchError((value) {
      codeController.clear();
      handleValidationException(value);
    });
  }

  resendCode() {
    _satorioRepository.resendCode().then(
      (isSuccess) {
        if (isSuccess) {
          codeController.clear();
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('txt_code_resend_success'.tr),
            ),
          );
        }
      },
    );
  }
}

class EmailVerificationArgument {
  final String? email;

  const EmailVerificationArgument(this.email);
}

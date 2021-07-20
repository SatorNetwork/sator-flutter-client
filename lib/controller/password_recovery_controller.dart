import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/password_recovery_binding.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/forgot_password_reset.dart';
import 'package:satorio/ui/page_widget/forgot_password_verification_page.dart';

class PasswordRecoveryController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void back() {
    Get.back();
  }

  void forgotPassword() {
    _satorioRepository.forgotPassword(emailController.text).then(
      (bool isSuccess) {
        if (isSuccess) {
          codeController.clear();
          Get.to(
            () => ForgotPasswordVerificationPage(),
            binding: PasswordRecoveryBinding(),
          );
        }
      },
    ).catchError((value) => handleValidationException(value));
  }

  void validateCode() {
    _satorioRepository
        .validateResetPasswordCode(emailController.text, codeController.text)
        .then(
      (bool isSuccess) {
        if (isSuccess) {
          newPasswordController.clear();
          Get.to(
            () => ForgotPasswordResetPage(),
            binding: PasswordRecoveryBinding(),
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

  void resetPassword() {
    _satorioRepository
        .resetPassword(
      emailController.text,
      codeController.text,
      newPasswordController.text,
    )
        .then(
      (bool isSuccess) {
        if (isSuccess) {
          Get.until((route) => Get.currentRoute == '/() => LoginPage');
        }
      },
    ).catchError((value) => handleValidationException(value));
  }

  void resendCode() {
    _satorioRepository.forgotPassword(emailController.text).then(
      (bool isSuccess) {
        if (isSuccess) {
          codeController.clear();
        }
      },
    ).catchError((value) => handleValidationException(value));
  }
}

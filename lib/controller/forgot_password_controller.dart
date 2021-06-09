import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void forgotPassword() {
    _satorioRepository.forgotPassword(emailController.text).then(
      (bool result) {
        if (result) {
          // TODO : to next step - validate code;
        }
      },
    );
  }

  void validateCode() {
    _satorioRepository
        .validateResetPasswordCode(emailController.text, codeController.text)
        .then(
      (bool result) {
        if (result) {
          // TODO : to next step - set new password;
        }
      },
    );
  }

  void resetPassword() {
    _satorioRepository
        .resetPassword(
      emailController.text,
      codeController.text,
      newPasswordController.text,
    )
        .then(
      (bool result) {
        if (result) {
          // TODO : finish forgot password process;
        }
      },
    );
  }
}

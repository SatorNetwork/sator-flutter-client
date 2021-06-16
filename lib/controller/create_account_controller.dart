import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class CreateAccountController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final RxBool termsOfServiceCheck = false.obs;
  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void toTermsOfService() {
    // TODO: move to Terms?
  }

  void toSignIn() {
    Get.off(() => LoginPage(), binding: LoginBinding());
  }

  void back() {
    Get.back();
  }

  void createAccount() {
    _satorioRepository
        .signUp(
      emailController.text,
      passwordController.text,
      usernameController.text,
    )
        .then((isSuccess) {
      if (isSuccess) {
        Get.to(() => EmailVerificationPage(), binding: CreateAccountBinding());
      }
    }).catchError((value) => handleValidationException(value));
  }

  void verifyAccount() {
    _satorioRepository
        .verifyAccount(
      codeController.text,
    )
        .then((isSuccess) {
      if (isSuccess) {
        Get.offAll(() => MainPage(), binding: MainBinding());
      } else {
        codeController.clear();
      }
    }).catchError((value) {
      codeController.clear();
      handleValidationException(value);
    });
  }
}

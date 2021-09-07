import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/binding/password_recovery_binding.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/forgot_password_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class LoginController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool passwordObscured = true.obs;
  final RxBool isRequested = false.obs;

  final SatorioRepository _satorioRepository = Get.find();

  late final Uri? deepLink;

  LoginController() {
    LoginArgument argument = Get.arguments as LoginArgument;
    print(argument.deepLink);
    deepLink = argument.deepLink;
  }

  void toCreateAccount() {
    Get.off(
          () => CreateAccountPage(),
      binding: CreateAccountBinding(),
      arguments: CreateAccountArgument(deepLink),
    );
  }

  void toForgotPassword() {
    Get.to(() => ForgotPasswordPage(), binding: PasswordRecoveryBinding());
  }

  void signIn() {
    Future.value(true)
        .then(
          (value) {
        isRequested.value = true;
        return value;
      },
    )
        .then(
          (value) =>
          _satorioRepository.signIn(
              emailController.text, passwordController.text),
    )
        .then(
          (isSuccess) {
        if (isSuccess) {
          _checkIsVerified();
        } else {
          isRequested.value = false;
        }
      },
    )
        .catchError(
          (value) {
        handleValidationException(value);
        isRequested.value = false;
      },
    );
  }

  void _checkIsVerified() {
    _satorioRepository.isVerified().then((isVerified) {
      if (isVerified)
        Get.offAll(() => MainPage(), binding: MainBinding());
      else
        Get.to(
              () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
        );
      isRequested.value = false;
    });
  }
}

class LoginArgument {
  final Uri? deepLink;

  const LoginArgument(this.deepLink);
}

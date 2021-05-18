import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void toCreateAccount() {
    Get.to(() => CreateAccountPage(), binding: CreateAccountBinding());
  }

  void toForgotPassword() {
    // TODO : Move to ForgotPassword screen
  }

  void signIn() {
    _satorioRepository
        .signIn(emailController.text, passwordController.text)
        .then((isSuccess) {
      // TODO : move to main
    });
  }
}

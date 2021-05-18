import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class CreateAccountController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final RxBool termsOfServiceCheck = false.obs;
  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void toTermsOfService() {
    // TODO: Do something
  }

  void toSignIn() {
    Get.back();
  }

  void createAccount() {
    _satorioRepository
        .signUp(emailController.text, passwordController.text,
            usernameController.text,)
        .then((isSuccess) {
      // TODO : move to main
    });
  }
}

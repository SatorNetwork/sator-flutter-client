import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool termsOfServiceCheck = false.obs;
  final RxBool passwordObscured = true.obs;

  void toTermsOfService() {
    // TODO: Do something
  }

  void toSignIn() {
    Get.back();
  }

  void createAccount() {
    // TODO: create account request
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool termsOfServiceCheck = false.obs;
  final RxBool passwordObscured = true.obs;

  void termsOfService() {
    // TODO: Do something
  }

  void signIn() {
    // TODO: Move To Sign In
  }

  void createAccount() {
    // TODO: create account request
  }
}

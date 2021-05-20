import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class CreateAccountController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final RxBool termsOfServiceCheck = false.obs;
  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void toTermsOfService() {
    // TODO: move to Terms?
  }

  void toSignIn() {
    Get.off(() => LoginPage(), binding: LoginBinding());
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
        Get.offAll(() => MainPage(), binding: MainBinding());
      }
    });
  }
}

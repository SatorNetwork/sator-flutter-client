import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class LoginController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool passwordObscured = true.obs;

  final SatorioRepository _satorioRepository = Get.find();

  void toCreateAccount() {
    Get.off(() => CreateAccountPage(), binding: CreateAccountBinding());
  }

  void signIn() {
    _satorioRepository
        .signIn(emailController.text, passwordController.text)
        .then((isSuccess) {
      if (isSuccess) {
        Get.offAll(() => MainPage(), binding: MainBinding());
      }
    }).catchError((value) => handleValidationException(value));
  }
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class EmailVerificationController extends GetxController with ValidationMixin {
  final TextEditingController codeController = TextEditingController();

  final SatorioRepository _satorioRepository = Get.find();

  void back() {
    Get.back();
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

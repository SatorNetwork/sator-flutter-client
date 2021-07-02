import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

mixin BackToMainMixin {
  void backToMain() {
    if (Get.isRegistered<SatorioRepository>()) {
      SatorioRepository satorioRepository = Get.find();
      satorioRepository.updateWalletBalance();
    }
    Get.until((route) => Get.currentRoute == '/() => MainPage');
  }
}

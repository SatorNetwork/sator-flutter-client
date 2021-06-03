import 'package:get/get.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/binding/onboarding_binding.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/main_page.dart';
import 'package:satorio/ui/page_widget/onboardinga_page.dart';

class SplashController extends GetxController {
  SatorioRepository _satorioRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  void dummy() {}

  void _checkToken() {
    Future.delayed(Duration(milliseconds: 1000), () {
      _satorioRepository.isTokenValid().then((isTokenValid) {
        if (isTokenValid) {
          Get.offAll(() => MainPage(), binding: MainBinding());
        } else {
          Get.off(() => OnBoardingPage(), binding: OnBoardingBinding());
        }
      });
    });
  }
}

import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/binding/onboarding_binding.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
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
          _checkIsVerified();
        } else {
          Get.off(() => LoginPage(), binding: LoginBinding());
        }
      }).catchError((value) {
        if (!(value is ApiUnauthorizedException))
          Get.off(() => LoginPage(), binding: LoginBinding());
      });
    });
  }

  void _checkIsVerified() {
    _satorioRepository.isVerified().then((isVerified) {
      if (isVerified)
        Get.offAll(() => MainPage(), binding: MainBinding());
      else
        Get.off(
          () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
        );
    });
  }
}

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/binding/onboarding_binding.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';
import 'package:satorio/ui/page_widget/onboardinga_page.dart';

class SplashController extends GetxController {
  SatorioRepository _satorioRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    _handleDynamicLinks();
    _checkToken();
  }

  Future _handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();

    void _handleDeepLink(PendingDynamicLinkData data) {
      final Uri? deepLink = data.link;
      if (deepLink != null) {

        print('_handleDeepLink | deeplink: $deepLink');
      }
    }

    _handleDeepLink(data!);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          _handleDeepLink(dynamicLink!);
        }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void dummy() {}

  void _checkToken() {
    Future.delayed(Duration(milliseconds: 1000), () {
      _satorioRepository.isTokenValid().then((isTokenValid) {
        if (isTokenValid) {
          _checkIsVerified();
        } else {
          Get.off(() => OnBoardingPage(), binding: OnBoardingBinding());
        }
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

import 'package:get/get.dart';
import 'package:satorio/binding/onboarding_binding.dart';
import 'package:satorio/ui/page_widget/onboardinga_page.dart';

class SplashController extends GetxController {
  void checkSomething() {
    // Check: is auth token valid? has onboard been viewed?
    Future.delayed(Duration(milliseconds: 500), () {
      Get.off(() => OnBoardingPage(), binding: OnBoardingBinding());
    });
  }
}

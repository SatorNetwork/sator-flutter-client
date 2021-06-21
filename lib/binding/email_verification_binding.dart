import 'package:get/get.dart';
import 'package:satorio/controller/email_verification_controller.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(
      () => EmailVerificationController(),
    );
  }
}

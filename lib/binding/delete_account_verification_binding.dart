import 'package:get/get.dart';
import 'package:satorio/controller/delete_account_verification_controller.dart';

class DeleteAccountVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteAccountVerificationController>(
      () => DeleteAccountVerificationController(),
    );
  }
}

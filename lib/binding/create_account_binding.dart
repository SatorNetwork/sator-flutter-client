import 'package:get/get.dart';
import 'package:satorio/controller/create_account_controller.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountController>(() => CreateAccountController());
  }
}

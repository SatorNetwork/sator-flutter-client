import 'package:get/get.dart';
import 'package:satorio/controller/wallet_receive_controller.dart';

class WalletReceiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletReceiveController>(() => WalletReceiveController());
  }
}

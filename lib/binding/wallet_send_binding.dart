import 'package:get/get.dart';
import 'package:satorio/controller/wallet_send_controller.dart';

class WalletSendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletSendController>(() => WalletSendController());
  }
}

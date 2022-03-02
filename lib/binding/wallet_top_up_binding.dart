import 'package:get/get.dart';
import 'package:satorio/controller/wallet_top_up_controller.dart';

class WalletTopUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletTopUpController>(() => WalletTopUpController());
  }
}

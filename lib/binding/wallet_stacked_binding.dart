import 'package:get/get.dart';
import 'package:satorio/controller/wallet_stacked_controller.dart';

class WalletStackedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletStackedController>(() => WalletStackedController());
  }
}

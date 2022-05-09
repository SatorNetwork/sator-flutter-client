import 'package:get/get.dart';
import 'package:satorio/controller/wallet_in_app_purchase_controller.dart';

class WalletInAppPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletInAppPurchaseController>(() => WalletInAppPurchaseController());
  }
}

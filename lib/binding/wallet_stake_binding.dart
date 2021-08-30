import 'package:get/get.dart';
import 'package:satorio/controller/wallet_stake_controller.dart';

class WalletStakeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletStakeController>(() => WalletStakeController());
  }
}

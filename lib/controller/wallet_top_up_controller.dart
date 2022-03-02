import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class WalletTopUpController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final RxBool isExchangeRx = false.obs;

  void back() {
    Get.back();
  }

  void toggle(bool isExchange) {
    isExchangeRx.value = isExchange;
  }
}

class WalletTopUpArguments {
  final WalletDetail walletDetail;

  const WalletTopUpArguments(this.walletDetail);
}

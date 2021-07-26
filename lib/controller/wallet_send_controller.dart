import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class WalletSendController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<WalletDetail?> walletDetailRx = Rx(null);

  void back() {
    Get.back();
  }
}

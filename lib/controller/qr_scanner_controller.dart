import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:satorio/binding/qr_result_show_binding.dart';
import 'package:satorio/binding/wallet_send_binding.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/qr_result_show_controller.dart';
import 'package:satorio/controller/wallet_send_controller.dart';
import 'package:satorio/data/model/qr/qr_data_factory.dart';
import 'package:satorio/domain/entities/qr/qr_data.dart';
import 'package:satorio/domain/entities/qr/qr_payload_show.dart';
import 'package:satorio/domain/entities/qr/qr_payload_wallet_send.dart';
import 'package:satorio/domain/entities/qr_show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/qr_result_show_page.dart';
import 'package:satorio/ui/page_widget/wallet_send_page.dart';

class QrScannerController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final RxBool isResultBackRx;
  Barcode? result;

  QrScannerController() {
    QrScannerArgument argument = Get.arguments as QrScannerArgument;
    isResultBackRx = argument.isResultBack.obs;
  }

  void back() {
    if (isResultBackRx.value)
      Get.back(result: null);
    else
      Get.back();
  }

  void startScan(QRViewController qrController) {
    qrController.scannedDataStream.listen((scanData) {
      if (result != null) return;
      result = scanData;
      _initScanner(result!.code.toString());
    });
  }

  void _initScanner(String scanData) {
    print(scanData);
    QrData data = QrDataModelFactory.createQrData(jsonDecode(scanData));
    switch (data.type) {
      case QrType.show:
        _handleShowData((data.payload as QrPayloadShow).code);
        break;
      case QrType.walletSend:
        _handleWalletData((data.payload as QrPayloadWalletSend).walletAddress);
        break;
    }
  }

  void _handleShowData(String code) {
    _satorioRepository.getShowEpisodeByQR(code).then((qrResult) {
      QrShow qrShow = qrResult;

      _satorioRepository.loadShow(qrShow.showId).then((show) {
        Get.off(
          () => QrResultShowPage(),
          binding: QrResultShowBinding(),
          arguments: QrResultShowArgument(show, qrShow),
        );
      });
    });
  }

  void _handleWalletData(String walletAddress) {
    if (isResultBackRx.value) {
      Get.back(result: walletAddress);
    } else {
      Get.off(
        () => WalletSendPage(),
        binding: WalletSendBinding(),
        arguments: WalletSendArgument(null, walletAddress),
      );
    }
  }
}

class QrScannerArgument {
  final bool isResultBack;

  const QrScannerArgument(this.isResultBack);
}

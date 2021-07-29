import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:satorio/binding/qr_result_show_binding.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/data/model/qr/qr_data_factory.dart';
import 'package:satorio/domain/entities/qr/qr_data.dart';
import 'package:satorio/domain/entities/qr/qr_show_pyaload.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/qr_result_show_page.dart';

class QrScannerController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();
  Barcode? result;

  void back() {
    Get.back();
  }

  void _loadShow(QrShowPayload showPayload) {
    _satorioRepository.loadShow(showPayload.showId).then((show) {
      Get.off(() => QrResultShowPage(show, showPayload),
          binding: QrResultShowBinding());
    });
  }

  void startScan(QRViewController qrController) {
    qrController.scannedDataStream.listen((scanData) {
      if (result != null) return;
      result = scanData;
      _initScanner(result!.code.toString());
    });
  }

  void _initScanner(String scanData) {
    QrData data = QrDataModelFactory.createQrData(jsonDecode(scanData));
    switch (data.type) {
      case QrType.show:
        _handleShowData(data.qrId);
        break;
      case QrType.wallet:
        _handleWalletData(data.qrId);
        break;
    }
  }

  void _handleShowData(String qrId) {
    _satorioRepository.getShowEpisodeByQR(qrId).then((qrResult) {
      QrShowPayload show = qrResult;
      _loadShow(show);
    });
  }

  void _handleWalletData(String qrId) {
    print("wallet type");
  }
}

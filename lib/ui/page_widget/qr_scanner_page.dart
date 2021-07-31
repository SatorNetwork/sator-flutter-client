import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:satorio/controller/qr_scanner_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class QrScannerPage extends GetView<QrScannerController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "txt_qr_scan".tr,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    const double padding = 40;

    var scanArea = (Get.width < 400 || Get.height < 400) ? 150.0 : 300.0;
    return Container(
      height: Get.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: controller.startScan,
            overlay: QrScannerOverlayShape(
                borderColor: SatorioColor.interactive,
                overlayColor: SatorioColor.textBlack.withOpacity(0.9),
                borderRadius: 28,
                borderLength: 80,
                borderWidth: 12,
                cutOutSize: scanArea),
          ),
          Positioned(
            bottom: 46,
            child: InkWell(
              onTap: () => controller.back(),
              child: Container(
                height: 50,
                width: Get.width - padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF4E4E4E),
                ),
                child: Center(
                  child: Text(
                    "txt_cancel".tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

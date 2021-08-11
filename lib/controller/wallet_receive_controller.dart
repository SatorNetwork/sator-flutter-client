import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:satorio/data/model/qr/qr_data_factory.dart';
import 'package:satorio/data/model/qr/qr_payload_wallet_send_model.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:share/share.dart';

class WalletReceiveController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);
  late final Rx<WalletDetail> walletDetailRx;
  late final RxString qrCodeDataRx;

  late ValueListenable<Box<Profile>> profileListenable;

  WalletReceiveController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
    profileListener();

    WalletReceiveArgument argument = Get.arguments as WalletReceiveArgument;
    walletDetailRx = Rx(argument.walletDetail);
    qrCodeDataRx = json
        .encode(
          QrDataWalletModel(
            QrPayloadWalletSendModel(
                argument.walletDetail.solanaAccountAddress),
          ).toJson(),
        )
        .obs;
  }

  @override
  void onInit() {
    super.onInit();
    profileListenable.addListener(profileListener);
  }

  @override
  void onClose() {
    profileListenable.removeListener(profileListener);
    super.onClose();
  }

  void back() {
    Get.back();
  }

  void copyAddress() {
    Clipboard.setData(
      ClipboardData(
        text: walletDetailRx.value.solanaAccountAddress,
      ),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  void shareQr() async {
    if (qrCodeDataRx.value.isNotEmpty) {
      final QrValidationResult qrValidationResult = QrValidator.validate(
        data: qrCodeDataRx.value,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      if (QrValidationStatus.valid == qrValidationResult.status &&
          qrValidationResult.qrCode != null) {
        final QrCode qrCode = qrValidationResult.qrCode!;
        final QrPainter painter = QrPainter.withQr(
          qr: qrCode,
          color: Colors.black,
          emptyColor: Colors.white,
          gapless: true,
          embeddedImageStyle: null,
          embeddedImage: null,
        );

        final Directory tempDir = await getTemporaryDirectory();
        final String path =
            '${tempDir.path}/${walletDetailRx.value.solanaAccountAddress}.png';

        final ByteData picData =
            (await painter.toImageData(1024, format: ImageByteFormat.png))!;
        final Uint8List pngBytes = picData.buffer.asUint8List();
        final File file = await new File(path).create();
        await file.writeAsBytes(pngBytes);
        Share.shareFiles([path]);
      }
    }
  }

  void profileListener() {
    if (profileListenable.value.length > 0) {
      profileRx.value = profileListenable.value.getAt(0);
    }
  }
}

class WalletReceiveArgument {
  final WalletDetail walletDetail;

  const WalletReceiveArgument(this.walletDetail);
}

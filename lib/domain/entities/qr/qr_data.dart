import 'package:satorio/domain/entities/qr/qr_payload.dart';
import 'package:satorio/domain/entities/qr/qr_show_pyaload.dart';
import 'package:satorio/domain/entities/qr/qr_wallet_pyaload.dart';

class QrData<T extends QrPayload> {
  final String qrId;
  final String type;
  final T payload;

  const QrData(this.qrId, this.type, this.payload);
}

class QrType {
  static const wallet = 'wallet';
  static const show = 'show';
}

class QrDataShow extends QrData<QrShowPayload> {
  QrDataShow(String qrId, QrShowPayload qrPayload)
      : super(qrId, QrType.show, qrPayload);
}

class QrDataWallet extends QrData<QrWalletPayload> {
  QrDataWallet(String qrId, QrWalletPayload qrPayload)
      : super(qrId, QrType.wallet, qrPayload);
}
import 'package:satorio/domain/entities/qr/qr_payload.dart';
import 'package:satorio/domain/entities/qr/qr_payload_show.dart';
import 'package:satorio/domain/entities/qr/qr_payload_wallet_send.dart';

class QrData<T extends QrPayload> {
  final String type;
  final T payload;

  const QrData(this.type, this.payload);
}

class QrType {
  static const walletSend = 'wallet_send';
  static const show = 'show';

  static const List<String> all = [walletSend, show];
}

class QrDataShow extends QrData<QrPayloadShow> {
  QrDataShow(QrPayloadShow qrPayload) : super(QrType.show, qrPayload);
}

class QrDataWalletSend extends QrData<QrPayloadWalletSend> {
  QrDataWalletSend(QrPayloadWalletSend qrPayload)
      : super(QrType.walletSend, qrPayload);
}

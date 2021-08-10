import 'package:satorio/domain/entities/qr/qr_payload.dart';

class QrPayloadWalletSend extends QrPayload {
  final String walletAddress;

  const QrPayloadWalletSend(this.walletAddress);
}

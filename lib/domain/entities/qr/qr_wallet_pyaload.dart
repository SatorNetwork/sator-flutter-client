import 'package:satorio/domain/entities/qr/qr_payload.dart';

class QrWalletPayload extends QrPayload {
  final String id;

  const QrWalletPayload(this.id);
}

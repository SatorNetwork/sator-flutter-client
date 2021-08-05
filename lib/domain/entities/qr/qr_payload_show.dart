import 'package:satorio/domain/entities/qr/qr_payload.dart';

class QrPayloadShow extends QrPayload {
  final String code;

  const QrPayloadShow(this.code);
}

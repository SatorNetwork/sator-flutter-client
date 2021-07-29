import 'package:satorio/domain/entities/qr/qr_payload.dart';

class QrShowPayload extends QrPayload {
  final String id;
  final String showId;
  final String episodeId;
  final int rewardAmount;

  const QrShowPayload(this.id, this.showId, this.episodeId, this.rewardAmount);
}

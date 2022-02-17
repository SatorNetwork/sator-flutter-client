import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';

class PayloadChallengeResult extends Payload {
  final String challengeId;
  final String prizePool;
  final String showTransactionUrl;
  final List<PayloadPlayer> winners;
  final List<PayloadPlayer> losers;

  const PayloadChallengeResult(
    this.challengeId,
    this.prizePool,
    this.showTransactionUrl,
    this.winners,
    this.losers,
  );
}

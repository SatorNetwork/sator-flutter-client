import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';

class PayloadChallengeResult extends Payload {
  final String challengeId;
  final String currentPrizePool;
  final String showTransactionUrl;
  final List<PayloadPlayer> winners;
  final List<PayloadPlayer> losers;

  const PayloadChallengeResult(
    this.challengeId,
    this.currentPrizePool,
    this.showTransactionUrl,
    this.winners,
    this.losers,
  );
}

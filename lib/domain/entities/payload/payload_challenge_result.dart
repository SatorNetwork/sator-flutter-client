import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';

class PayloadChallengeResult extends Payload {
  final String challengeId;
  final String currentPrizePool;
  final String showTransactionUrl;
  final List<PayloadPlayer> winners;
  final List<PayloadPlayer> losers;
  final bool isRewardsDisabled;
  final List<PayloadPlayer> players;

  const PayloadChallengeResult(
    this.challengeId,
    this.currentPrizePool,
    this.showTransactionUrl,
    this.winners,
    this.losers,
    this.isRewardsDisabled,
    this.players,
  );
}

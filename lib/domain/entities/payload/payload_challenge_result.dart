import 'package:satorio/domain/entities/payload/payload.dart';
import 'package:satorio/domain/entities/payload/payload_winner.dart';

class PayloadChallengeResult extends Payload {
  final String challengeId;
  final String prizePool;
  final String showTransactionUrl;
  final List<PayloadWinner> winners;

  const PayloadChallengeResult(
    this.challengeId,
    this.prizePool,
    this.showTransactionUrl,
    this.winners,
  );
}

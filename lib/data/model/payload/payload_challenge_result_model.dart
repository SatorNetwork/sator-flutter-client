import 'package:satorio/data/model/payload/payload_winner_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_winner.dart';

class PayloadChallengeResultModel extends PayloadChallengeResult
    implements ToJsonInterface {
  const PayloadChallengeResultModel(
    String challengeId,
    String prizePool,
    String showTransactionUrl,
    List<PayloadWinner> winners,
  ) : super(challengeId, prizePool, showTransactionUrl, winners);

  factory PayloadChallengeResultModel.fromJson(Map json) =>
      PayloadChallengeResultModel(
        json['challenge_id'] == null ? '' : json['challenge_id'],
        json['prize_pool'] == null ? '' : json['prize_pool'],
        json['show_transaction_url'] == null
            ? ''
            : json['show_transaction_url'],
        (json['winners'] == null || !(json['winners'] is Iterable))
            ? []
            : (json['winners'] as Iterable)
                .where((element) => element != null)
                .map((element) => PayloadWinnerModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'challenge_id': challengeId,
        'prize_pool': prizePool,
        'show_transaction_url': showTransactionUrl,
        'winners': winners
            .where((element) => element is ToJsonInterface)
            .map((element) => (element as ToJsonInterface).toJson())
            .toList(),
      };
}

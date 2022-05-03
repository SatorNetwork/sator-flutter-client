import 'package:satorio/data/model/payload/payload_player_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';
import 'package:satorio/util/extension.dart';

class PayloadChallengeResultModel extends PayloadChallengeResult
    implements ToJsonInterface {
  const PayloadChallengeResultModel(
    String challengeId,
    String currentPrizePool,
    String showTransactionUrl,
    List<PayloadPlayer> winners,
    List<PayloadPlayer> losers,
  ) : super(
          challengeId,
          currentPrizePool,
          showTransactionUrl,
          winners,
          losers,
        );

  factory PayloadChallengeResultModel.fromJson(Map json) =>
      PayloadChallengeResultModel(
        json.parseValueAsString('challenge_id'),
        json.parseValueAsString('current_prize_pool'),
        json.parseValueAsString('show_transaction_url'),
        (json['winners'] == null || !(json['winners'] is Iterable))
            ? []
            : (json['winners'] as Iterable)
                .where((element) => element != null)
                .map((element) => PayloadPlayerModel.fromJson(element))
                .toList(),
        (json['losers'] == null || !(json['losers'] is Iterable))
            ? []
            : (json['losers'] as Iterable)
                .where((element) => element != null)
                .map((element) => PayloadPlayerModel.fromJson(element))
                .toList(),
      );

  @override
  Map toJson() => {
        'challenge_id': challengeId,
        'current_prize_pool': currentPrizePool,
        'show_transaction_url': showTransactionUrl,
        'winners': winners
            .whereType<ToJsonInterface>()
            .map((element) => element.toJson())
            .toList(),
        'losers': losers
            .whereType<ToJsonInterface>()
            .map((element) => element.toJson())
            .toList(),
      };
}

import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/util/extension.dart';

class ChallengeSimpleModel extends ChallengeSimple implements ToJsonInterface {
  const ChallengeSimpleModel(
    String id,
    String title,
    int playersToStart,
    int playersCount,
    String prizePool,
    bool isRealmActivated,
  ) : super(
          id,
          title,
          playersToStart,
          playersCount,
          prizePool,
          isRealmActivated,
        );

  factory ChallengeSimpleModel.fromJson(Map json) => ChallengeSimpleModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsInt('players_to_start'),
        json.parseValueAsInt('players_number'),
        json.parseValueAsString('prize_pool'),
        json.parseValueAsBool('is_realm_activated'),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'players_to_start': playersToStart,
        'players_number': playersCount,
        'prize_pool': prizePool,
        'is_realm_activated': isRealmActivated
      };
}

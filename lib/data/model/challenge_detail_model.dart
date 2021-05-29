import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge_detail.dart';

class ChallengeDetailModel extends ChallengeDetail implements ToJsonInterface {
  const ChallengeDetailModel(
    String id,
    String title,
    String description,
    String prizePool,
    int players,
    String winners,
    String timePerQuestion,
    String play,
  ) : super(
          id,
          title,
          description,
          prizePool,
          players,
          winners,
          timePerQuestion,
          play,
        );

  factory ChallengeDetailModel.fromJson(Map json) => ChallengeDetailModel(
        json['id'] == null ? '' : json['id'],
        json['title'] == null ? '' : json['title'],
        json['description'] == null ? '' : json['description'],
        json['prize_pool'] == null ? '' : json['prize_pool'],
        json['players'] == null ? 0 : json['players'],
        json['winners'] == null ? '' : json['winners'],
        json['time_per_question'] == null ? '' : json['time_per_question'],
        json['play'] == null ? '' : json['play'],
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'prize_pool': prizePool,
        'players': players,
        'winners': winners,
        'time_per_question': timePerQuestion,
        'play': play,
      };
}

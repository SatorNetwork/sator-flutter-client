import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge_detail.dart';

class ChallengeDetailModel extends ChallengeDetail implements ToJsonInterface {
  const ChallengeDetailModel(
    String id,
    String title,
    String description,
    String prizePool,
    int playersToStart,
    String timePerQuestion,
    String playUrl,
  ) : super(
          id,
          title,
          description,
          prizePool,
          playersToStart,
          timePerQuestion,
          playUrl,
        );

  factory ChallengeDetailModel.fromJson(Map json) => ChallengeDetailModel(
        json['id'] == null ? '' : json['id'],
        json['title'] == null ? '' : json['title'],
        json['description'] == null ? '' : json['description'],
        json['prize_pool'] == null ? '' : json['prize_pool'],
        json['players_to_start'] == null ? 0 : json['players_to_start'],
        json['time_per_question'] == null ? '' : json['time_per_question'],
        json['play_url'] == null ? '' : json['play_url'],
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'prize_pool': prizePool,
        'players_to_start': playersToStart,
        'time_per_question': timePerQuestion,
        'play_url': playUrl,
      };
}

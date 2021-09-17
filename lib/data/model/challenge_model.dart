import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge.dart';

class ChallengeModel extends Challenge implements ToJsonInterface {
  const ChallengeModel(
    String id,
    String title,
    String description,
    String prizePool,
    int players,
    String winners,
    String timePerQuestion,
    String play,
    int userMaxAttempts,
    int attemptsLeft,
  ) : super(
          id,
          title,
          description,
          prizePool,
          players,
          winners,
          timePerQuestion,
          play,
          userMaxAttempts,
          attemptsLeft,
        );

  factory ChallengeModel.fromJson(Map json) => ChallengeModel(
        json['id'] == null ? '' : json['id'],
        json['title'] == null ? '' : json['title'],
        json['description'] == null ? '' : json['description'],
        json['prize_pool'] == null ? '' : json['prize_pool'],
        json['players'] == null ? 0 : json['players'],
        json['winners'] == null ? '' : json['winners'],
        json['time_per_question'] == null ? '' : json['time_per_question'],
        json['play'] == null ? '' : json['play'],
        json['user_max_attempts'] == null ? 0 : json['user_max_attempts'],
        json['attempts_left'] == null ? 0 : json['attempts_left'],
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
        'user_max_attempts': userMaxAttempts,
        'attempts_left': attemptsLeft,
      };
}

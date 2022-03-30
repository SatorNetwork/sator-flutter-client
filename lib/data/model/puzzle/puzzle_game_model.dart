import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/puzzle/puzzle_game.dart';
import 'package:satorio/util/extension.dart';

class PuzzleGameModel extends PuzzleGame implements ToJsonInterface {
  const PuzzleGameModel(
    String id,
    String episodeId,
    double prizePool,
    double rewards,
    double bonusRewards,
    int xSize,
    int steps,
    int stepsTaken,
    int status,
    int result,
    String image,
  ) : super(
          id,
          episodeId,
          prizePool,
          rewards,
          bonusRewards,
          xSize,
          steps,
          stepsTaken,
          status,
          result,
          image,
        );

  factory PuzzleGameModel.fromJson(Map json) => PuzzleGameModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('episode_id'),
        json.parseValueAsDouble('prize_pool'),
        json.parseValueAsDouble('rewards'),
        json.parseValueAsDouble('rewards'),
        json.parseValueAsInt('parts_x'),
        json.parseValueAsInt('steps'),
        json.parseValueAsInt('steps_taken'),
        json.parseValueAsInt('status'),
        json.parseValueAsInt('result'),
        json.parseValueAsString('image'),
      );

  @override
  Map toJson() => {
        'id': id,
        'episode_id': episodeId,
        'prize_pool': prizePool,
        'rewards': rewards,
        'bonus_rewards': bonusRewards,
        'parts_x': xSize,
        'steps': steps,
        'steps_taken': stepsTaken,
        'status': status,
        'result': result,
        'image': image,
      };
}

import 'package:satorio/data/model/puzzle/tile_model.dart';
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
    String image,
    List<TileModel> tiles,
    bool isRewardsEnabled,
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
          image,
          tiles,
          isRewardsEnabled,
        );

  factory PuzzleGameModel.fromJson(Map json) => PuzzleGameModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('episode_id'),
        json.parseValueAsDouble('prize_pool'),
        json.parseValueAsDouble('rewards'),
        json.parseValueAsDouble('bonus_rewards'),
        json.parseValueAsInt('parts_x'),
        json.parseValueAsInt('steps'),
        json.parseValueAsInt('steps_taken'),
        json.parseValueAsInt('status'),
        json.parseValueAsString('image'),
        json['tiles'] != null && json['tiles'] is Iterable
            ? (json['tiles'] as Iterable)
                .where((element) => element != null)
                .map((element) => TileModel.fromJson(element))
                .toList()
            : [],
        json.parseValueAsBool('rewards_enabled'),
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
        'image': image,
        'tiles': tiles
            .whereType<ToJsonInterface>()
            .map((element) => element.toJson())
            .toList(),
        'rewards_enabled': isRewardsEnabled,
      };
}

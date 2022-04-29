import 'package:satorio/domain/entities/puzzle/tile.dart';

class PuzzleGame {
  final String id;
  final String episodeId;
  final double prizePool;
  final double rewards;
  final double bonusRewards;
  final int xSize;
  final int steps;
  final int stepsTaken;
  final int status;
  final String image;
  final List<Tile> tiles;

  const PuzzleGame(
    this.id,
    this.episodeId,
    this.prizePool,
    this.rewards,
    this.bonusRewards,
    this.xSize,
    this.steps,
    this.stepsTaken,
    this.status,
    this.image,
    this.tiles,
  );
}

class PuzzleGameStatus {
  static const newGame = 0;
  static const inProgress = 1;
  static const finished = 2;
  static const stepLimit = 3;
}

class PuzzleGame {
  final String id;
  final String episodeId;
  final double prizePool;
  final double rewards;
  final double bonusRewards;
  final int xSize;
  final int steps;
  final int stepsTaken;
  final int status; // 0 - not started, 1 - in progress, 2 - finished
  final int result; // 0 - not finished, 1 - user won, 2 - user lost
  final String image;

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
    this.result,
    this.image,
  );
}

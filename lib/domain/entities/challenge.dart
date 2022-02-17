class Challenge {
  final String id;
  final String showId;
  final String episodeId;
  final String title;
  final String description;
  final String prizePool;
  final double prizePoolAmount;
  final int players;
  final String winners;
  final String timePerQuestion;
  final int timePerQuestionSec;
  final String play;
  final int userMaxAttempts;
  final int attemptsLeft;
  final double receivedReward;
  final String receivedRewardAsString;
  final int maxWinners;
  final int questionsPerGame;
  final int minCorrectAnswers;
  final bool isRealmActivated;
  final int registeredPlayers;

  const Challenge(
    this.id,
    this.showId,
    this.episodeId,
    this.title,
    this.description,
    this.prizePool,
    this.prizePoolAmount,
    this.players,
    this.winners,
    this.timePerQuestion,
    this.timePerQuestionSec,
    this.play,
    this.userMaxAttempts,
    this.attemptsLeft,
    this.receivedReward,
    this.receivedRewardAsString,
    this.maxWinners,
    this.questionsPerGame,
    this.minCorrectAnswers,
    this.isRealmActivated,
    this.registeredPlayers,
  );
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final String prizePool;
  final int players;
  final String winners;
  final String timePerQuestion;
  final String play;
  final int userMaxAttempts;
  final int attemptsLeft;

  const Challenge(
    this.id,
    this.title,
    this.description,
    this.prizePool,
    this.players,
    this.winners,
    this.timePerQuestion,
    this.play,
    this.userMaxAttempts,
    this.attemptsLeft,
  );
}

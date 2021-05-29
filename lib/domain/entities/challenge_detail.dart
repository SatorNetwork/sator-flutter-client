class ChallengeDetail {
  final String id;
  final String title;
  final String description;
  final String prizePool;
  final int players;
  final String winners;
  final String timePerQuestion;
  final String play;

  const ChallengeDetail(this.id, this.title, this.description, this.prizePool,
      this.players, this.winners, this.timePerQuestion, this.play);
}

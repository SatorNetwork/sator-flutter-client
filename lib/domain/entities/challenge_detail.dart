class ChallengeDetail {
  final String id;
  final String title;
  final String description;
  final String prizePool;
  final int playersToStart;
  final String timePerQuestion;
  final String playUrl;

  const ChallengeDetail(this.id, this.title, this.description, this.prizePool,
      this.playersToStart, this.timePerQuestion, this.playUrl);
}

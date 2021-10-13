class ActivatedEpisode {
  final String id;
  final String showId;
  final String seasonId;
  final int episodeNumber;
  final String cover;
  final String title;
  final String description;
  final DateTime? releaseDate;
  final String challengeId;
  final String verificationChallengeId;

  const ActivatedEpisode(
      this.id,
      this.showId,
      this.seasonId,
      this.episodeNumber,
      this.cover,
      this.title,
      this.description,
      this.releaseDate,
      this.challengeId,
      this.verificationChallengeId);
}

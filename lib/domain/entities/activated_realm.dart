class ActivatedRealm {
  final String id;
  final String showId;
  final String episodeId;
  final String seasonId;
  final int episodeNumber;
  final int seasonNumber;
  final String cover;
  final String title;
  final String showTitle;
  final String description;
  final DateTime? releaseDate;
  final String challengeId;
  final String verificationChallengeId;

  const ActivatedRealm(
      this.id,
      this.showId,
      this.episodeId,
      this.seasonId,
      this.episodeNumber,
      this.seasonNumber,
      this.cover,
      this.title,
      this.showTitle,
      this.description,
      this.releaseDate,
      this.challengeId,
      this.verificationChallengeId);
}

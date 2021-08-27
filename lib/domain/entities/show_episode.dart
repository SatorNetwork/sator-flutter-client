class ShowEpisode {
  final String id;
  final String showId;
  final String challengeId;
  final int episodeNumber;
  final String title;
  final String description;
  final String cover;
  final DateTime? releaseDate;
  final double rating;

  const ShowEpisode(this.id, this.showId, this.challengeId, this.episodeNumber,
      this.title, this.description, this.cover, this.releaseDate, this.rating);
}

import 'package:satorio/domain/entities/show_episode.dart';

class ShowSeason {
  final String id;
  final int seasonNumber;
  final String title;
  final List<ShowEpisode> episodes;

  const ShowSeason(this.id, this.seasonNumber, this.title, this.episodes);
}

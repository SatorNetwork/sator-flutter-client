import 'package:satorio/data/model/show_episode_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';

class ShowSeasonModel extends ShowSeason implements ToJsonInterface {
  const ShowSeasonModel(
      String id, int seasonNumber, String title, List<ShowEpisode> episodes)
      : super(id, seasonNumber, title, episodes);

  factory ShowSeasonModel.fromJson(Map json) {
    List<ShowEpisodeModel> episodes =
        (json['episodes'] == null || !(json['episodes'] is Iterable))
            ? []
            : (json['episodes'] as Iterable)
                .where((element) => element != null)
                .map((element) => ShowEpisodeModel.fromJson(element))
                .toList();
    episodes.sort((a, b) => a.episodeNumber.compareTo(b.episodeNumber));

    return ShowSeasonModel(
      json['id'] == null ? '' : json['id'],
      json['season_number'] == null ? 0 : json['season_number'],
      json['title'] == null ? '' : json['title'],
      episodes,
    );
  }

  @override
  Map toJson() => {
        'id': id,
        'season_number': seasonNumber,
        'title': title,
        'episodes': episodes
            .where((element) => element is ToJsonInterface)
            .map((element) => (element as ToJsonInterface).toJson())
            .toList(),
      };
}

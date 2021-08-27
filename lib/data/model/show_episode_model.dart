import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_episode.dart';

class ShowEpisodeModel extends ShowEpisode implements ToJsonInterface {
  const ShowEpisodeModel(
    String id,
    String showId,
    String challengeId,
    int episodeNumber,
    String title,
    String description,
    String cover,
    DateTime? releaseDate,
    double rating,
  ) : super(
          id,
          showId,
          challengeId,
          episodeNumber,
          title,
          description,
          cover,
          releaseDate,
          rating,
        );

  factory ShowEpisodeModel.fromJson(Map json) {
    DateTime? releaseDate;
    if (json['release_date'] != null) {
      releaseDate = DateTime.tryParse(json['release_date']);
    }

    double rating = json['rating'] == null
        ? 0.0
        : (json['rating'] is int
            ? (json['rating'] as int).toDouble()
            : json['rating']);

    return ShowEpisodeModel(
      json['id'] == null ? '' : json['id'],
      json['show_id'] == null ? '' : json['show_id'],
      json['challenge_id'] == null ? '' : json['challenge_id'],
      json['episode_number'] == null ? 0 : json['episode_number'],
      json['title'] == null ? '' : json['title'],
      json['description'] == null ? '' : json['description'],
      json['cover'] == null ? '' : json['cover'],
      releaseDate,
      rating,
    );
  }

  @override
  Map toJson() => {
        'id': id,
        'show_id': showId,
        'challenge_id': challengeId,
        'episode_number': episodeNumber,
        'title': title,
        'description': description,
        'cover': cover,
        'release_date': releaseDate?.toIso8601String() ?? '',
        'rating': rating,
      };
}

import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/util/extension.dart';

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
    int ratingsCount,
    int activeUsers,
    double userRewardsAmount,
    double totalRewardsAmount,
    String hint,
    String watch,
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
          ratingsCount,
          activeUsers,
          userRewardsAmount,
          totalRewardsAmount,
          hint,
          watch,
        );

  factory ShowEpisodeModel.fromJson(Map json) => ShowEpisodeModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('show_id'),
        json.parseValueAsString('challenge_id'),
        json.parseValueAsInt('episode_number'),
        json.parseValueAsString('title'),
        json.parseValueAsString('description'),
        json.parseValueAsString('cover'),
        json.tryParseValueAsDateTime('release_date'),
        json.parseValueAsDouble('rating'),
        json.parseValueAsInt('ratings_count'),
        json.parseValueAsInt('active_users'),
        json.parseValueAsDouble('user_rewards_amount'),
        json.parseValueAsDouble('total_rewards_amount'),
        json.parseValueAsString('hint_text'),
        json.parseValueAsString('watch'),
      );

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
        'ratings_count': ratingsCount,
        'active_users': activeUsers,
        'user_rewards_amount': userRewardsAmount,
        'total_rewards_amount': totalRewardsAmount,
        'hint_text': hint,
        'watch': watch,
      };
}

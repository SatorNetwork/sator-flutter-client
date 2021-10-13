import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/activated_episode_simple.dart';
import 'package:satorio/util/extension.dart';

class ActivatedEpisodeModel extends ActivatedEpisode
    implements ToJsonInterface {
  const ActivatedEpisodeModel(
    String id,
    String showId,
    String seasonId,
    int episodeNumber,
    String cover,
    String title,
    String description,
    DateTime? releaseDate,
    String challengeId,
    String verificationChallengeId,
  ) : super(
          id,
          showId,
          seasonId,
          episodeNumber,
          cover,
          title,
          description,
          releaseDate,
          challengeId,
          verificationChallengeId,
        );

  factory ActivatedEpisodeModel.fromJson(Map json) => ActivatedEpisodeModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('show_id'),
        json.parseValueAsString('season_id'),
        json.parseValueAsInt('episode_number'),
        json.parseValueAsString('cover'),
        json.parseValueAsString('title'),
        json.parseValueAsString('description'),
        json.tryParseValueAsDateTime('release_date'),
        json.parseValueAsString('challenge_id'),
        json.parseValueAsString('verification_challenge_id'),
      );

  @override
  Map toJson() => {
        'id': id,
        'show_id': showId,
        'season_id': seasonId,
        'episode_number': episodeNumber,
        'cover': cover,
        'title': title,
        'description': description,
        'release_date': releaseDate?.toIso8601String() ?? '',
        'challenge_id': challengeId,
        'verification_challenge_id': verificationChallengeId,
      };
}

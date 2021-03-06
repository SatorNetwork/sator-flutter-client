import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/activated_realm.dart';
import 'package:satorio/util/extension.dart';

class ActivatedRealmModel extends ActivatedRealm implements ToJsonInterface {
  const ActivatedRealmModel(
    String id,
    String showId,
    String episodeId,
    String seasonId,
    int episodeNumber,
    int seasonNumber,
    String cover,
    String title,
    String showTitle,
    String description,
    DateTime? releaseDate,
    String challengeId,
    String verificationChallengeId,
  ) : super(
          id,
          showId,
          episodeId,
          seasonId,
          episodeNumber,
          seasonNumber,
          cover,
          title,
          showTitle,
          description,
          releaseDate,
          challengeId,
          verificationChallengeId,
        );

  factory ActivatedRealmModel.fromJson(Map json) => ActivatedRealmModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('show_id'),
        json.parseValueAsString('episode_id'),
        json.parseValueAsString('season_id'),
        json.parseValueAsInt('episode_number'),
        json.parseValueAsInt('season_number'),
        json.parseValueAsString('cover'),
        json.parseValueAsString('title'),
        json.parseValueAsString('show_title'),
        json.parseValueAsString('description'),
        json.tryParseValueAsDateTime('release_date'),
        json.parseValueAsString('challenge_id'),
        json.parseValueAsString('verification_challenge_id'),
      );

  @override
  Map toJson() => {
        'id': id,
        'show_id': showId,
        'episode_id': episodeId,
        'season_id': seasonId,
        'episode_number': episodeNumber,
        'season_number': seasonNumber,
        'cover': cover,
        'title': title,
        'show_title': showTitle,
        'description': description,
        'release_date': releaseDate?.toIso8601String() ?? '',
        'challenge_id': challengeId,
        'verification_challenge_id': verificationChallengeId,
      };
}

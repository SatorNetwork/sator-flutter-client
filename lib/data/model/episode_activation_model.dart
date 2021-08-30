import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/episode_activation.dart';

class EpisodeActivationModel extends EpisodeActivation
    implements ToJsonInterface {
  const EpisodeActivationModel(
    bool isActive,
    DateTime? activatedAt,
    DateTime? activatedBefore,
  ) : super(
          isActive,
          activatedAt,
          activatedBefore,
        );

  factory EpisodeActivationModel.fromJson(Map json) {
    DateTime? activatedAt;
    if (json['activated_at'] != null)
      activatedAt = DateTime.tryParse(json['activated_at']);

    DateTime? activatedBefore;
    if (json['activated_before'] != null)
      activatedBefore = DateTime.tryParse(json['activated_before']);

    return EpisodeActivationModel(
      json['result'] == null ? false : json['result'],
      activatedAt,
      activatedBefore,
    );
  }

  @override
  Map toJson() => {
        'result': isActive,
        'activated_at': activatedAt?.toIso8601String() ?? '',
        'activated_before': activatedBefore?.toIso8601String() ?? '',
      };
}

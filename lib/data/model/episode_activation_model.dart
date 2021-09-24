import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/util/extension.dart';

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

  factory EpisodeActivationModel.fromJson(Map json) => EpisodeActivationModel(
        json.parseValueAsBool('result'),
        json.tryParseValueAsDateTime('activated_at'),
        json.tryParseValueAsDateTime('activated_before'),
      );

  @override
  Map toJson() => {
        'result': isActive,
        'activated_at': activatedAt?.toIso8601String() ?? '',
        'activated_before': activatedBefore?.toIso8601String() ?? '',
      };
}

import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr_show.dart';
import 'package:satorio/util/extension.dart';

class QrShowModel extends QrShow implements ToJsonInterface {
  const QrShowModel(
    String id,
    String showId,
    String episodeId,
    double rewardAmount,
  ) : super(
          id,
          showId,
          episodeId,
          rewardAmount,
        );

  factory QrShowModel.fromJson(Map json) => QrShowModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('show_id'),
        json.parseValueAsString('episode_id'),
        json.parseValueAsDouble('reward_amount'),
      );

  @override
  Map toJson() => {
        'id': id,
        'show_id': showId,
        'episode_id': episodeId,
        'reward_amount': rewardAmount,
      };
}

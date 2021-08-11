import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/qr_show.dart';

class QrShowModel extends QrShow implements ToJsonInterface {
  const QrShowModel(
      String id, String showId, String episodeId, int rewardAmount)
      : super(id, showId, episodeId, rewardAmount);

  factory QrShowModel.fromJson(Map json) => QrShowModel(
        json['id'] == null ? '' : json['id'],
        json['show_id'] == null ? '' : json['show_id'],
        json['episode_id'] == null ? '' : json['episode_id'],
        json['reward_amount'] == null ? '' : json['reward_amount'],
      );

  @override
  Map toJson() => {
        'id': id,
        'show_id': showId,
        'episode_id': episodeId,
        'reward_amount': rewardAmount,
      };
}

import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';
import 'package:satorio/util/extension.dart';

class PayloadPlayerModel extends PayloadPlayer implements ToJsonInterface {
  const PayloadPlayerModel(
    String userId,
    String username,
    String avatar,
    String prize,
  ) : super(
          userId,
          username,
          avatar,
          prize,
        );

  factory PayloadPlayerModel.fromJson(Map json) => PayloadPlayerModel(
        json.parseValueAsString('user_id'),
        json.parseValueAsString('username'),
        json.parseValueAsString('avatar'),
        json.parseValueAsString('prize'),
      );

  @override
  Map toJson() => {
        'user_id': userId,
        'username': username,
        'prize': prize,
      };
}

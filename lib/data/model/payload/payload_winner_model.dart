import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_winner.dart';

class PayloadWinnerModel extends PayloadWinner implements ToJsonInterface {
  const PayloadWinnerModel(String userId, String username, double prize)
      : super(userId, username, prize);

  factory PayloadWinnerModel.fromJson(Map json) => PayloadWinnerModel(
        json['user_id'] == null ? '' : json['user_id'],
        json['username'] == null ? '' : json['username'],
        json['prize'] == null ? 0.0 : json['prize'],
      );

  @override
  Map toJson() => {
        'user_id': userId,
        'username': username,
        'prize': prize,
      };
}

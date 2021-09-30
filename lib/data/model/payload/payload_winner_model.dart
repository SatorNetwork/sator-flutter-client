import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_winner.dart';
import 'package:satorio/util/extension.dart';

class PayloadWinnerModel extends PayloadWinner implements ToJsonInterface {
  const PayloadWinnerModel(
    String userId,
    String username,
    String prize,
  ) : super(
          userId,
          username,
          prize,
        );

  factory PayloadWinnerModel.fromJson(Map json) => PayloadWinnerModel(
        json.parseValueAsString('user_id'),
        json.parseValueAsString('username'),
        json.parseValueAsString('prize'),
      );

  @override
  Map toJson() => {
        'user_id': userId,
        'username': username,
        'prize': prize,
      };
}

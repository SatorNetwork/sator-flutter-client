import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_connect.dart';

class PayloadConnectModel extends PayloadConnect implements ToJsonInterface {
  const PayloadConnectModel(String userId, String username)
      : super(userId, username);

  factory PayloadConnectModel.fromJson(Map json) => PayloadConnectModel(
        json['user_id'] == null ? '' : json['user_id'],
        json['username'] == null ? '' : json['username'],
      );

  @override
  Map toJson() => {
        'user_id': userId,
        'username': username,
      };
}

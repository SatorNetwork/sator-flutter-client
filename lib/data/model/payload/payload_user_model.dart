import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';
import 'package:satorio/util/extension.dart';

class PayloadUserModel extends PayloadUser implements ToJsonInterface {
  const PayloadUserModel(
    String userId,
    String username,
  ) : super(
          userId,
          username,
        );

  factory PayloadUserModel.fromJson(Map json) => PayloadUserModel(
        json.parseValueAsString('user_id'),
        json.parseValueAsString('username'),
      );

  @override
  Map toJson() => {
        'user_id': userId,
        'username': username,
      };
}

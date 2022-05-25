import 'package:satorio/data/model/to_json_interface.dart';

class RegisterTokenRequest implements ToJsonInterface {
  final String deviceId;
  final String token;

  const RegisterTokenRequest(this.deviceId, this.token);

  @override
  Map toJson() => {
        'device_id': deviceId,
        'token': token,
      };
}

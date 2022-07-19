import 'package:satorio/data/model/to_json_interface.dart';

class VerifyCodeRequest implements ToJsonInterface {
  final String otp;

  const VerifyCodeRequest(this.otp);

  @override
  Map<String, String> toJson() => {
        'otp': otp,
      };
}

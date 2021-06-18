import 'package:satorio/data/model/to_json_interface.dart';

class VerifyAccountRequest implements ToJsonInterface {
  final String otp;

  const VerifyAccountRequest(this.otp);

  @override
  Map<String, String> toJson() =>
      {'otp': otp};
}

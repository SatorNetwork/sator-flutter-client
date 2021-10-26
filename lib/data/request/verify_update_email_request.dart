import 'package:satorio/data/model/to_json_interface.dart';

class VerifyUpdateEmailRequest implements ToJsonInterface {
  final String email;
  final String otp;

  const VerifyUpdateEmailRequest(this.email, this.otp);

  @override
  Map<String, String> toJson() =>
      {'email': email, 'otp': otp};
}

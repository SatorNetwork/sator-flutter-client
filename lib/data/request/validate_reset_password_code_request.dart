import 'package:satorio/data/model/to_json_interface.dart';

class ValidateResetPasswordCodeRequest implements ToJsonInterface {
  final String email;
  final String otp;

  const ValidateResetPasswordCodeRequest(this.email, this.otp);

  @override
  Map toJson() => {
        'email': email,
        'otp': otp,
      };
}

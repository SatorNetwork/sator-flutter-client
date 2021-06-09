import 'package:satorio/data/model/to_json_interface.dart';

class ResetPasswordRequest implements ToJsonInterface {
  final String email;
  final String otp;
  final String password;

  const ResetPasswordRequest(this.email, this.otp, this.password);

  @override
  Map toJson() => {
        'email': email,
        'otp': otp,
        'password': password,
      };
}

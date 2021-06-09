import 'package:satorio/data/model/to_json_interface.dart';

class ForgotPasswordRequest implements ToJsonInterface {
  final String email;

  const ForgotPasswordRequest(this.email);

  @override
  Map toJson() => {
        'email': email,
      };
}

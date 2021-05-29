import 'package:satorio/data/model/to_json_interface.dart';

class SignUpRequest implements ToJsonInterface {
  final String email;
  final String password;
  final String username;

  const SignUpRequest(this.email, this.password, this.username);

  @override
  Map<String, String> toJson() =>
      {'email': email, 'password': password, 'username': username};
}

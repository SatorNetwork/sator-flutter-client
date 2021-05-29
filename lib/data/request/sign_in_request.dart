import 'package:satorio/data/model/to_json_interface.dart';

class SignInRequest implements ToJsonInterface {
  final String email;
  final String password;

  const SignInRequest(this.email, this.password);

  @override
  Map toJson() => {'email': email, 'password': password};
}

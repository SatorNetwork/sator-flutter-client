import 'package:satorio/data/model/to_json_interface.dart';

class UpdateUsernameRequest implements ToJsonInterface {
  final String username;

  const UpdateUsernameRequest(this.username);

  @override
  Map<String, String> toJson() =>
      {'username': username};
}

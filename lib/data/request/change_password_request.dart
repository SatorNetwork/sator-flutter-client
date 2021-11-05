import 'package:satorio/data/model/to_json_interface.dart';

class ChangePasswordRequest implements ToJsonInterface {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRequest(this.oldPassword, this.newPassword);

  @override
  Map<String, String> toJson() =>
      {
        'old_password': oldPassword,
        'new_password': newPassword,
      };
}

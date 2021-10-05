import 'package:satorio/data/model/to_json_interface.dart';

class SelectAvatarRequest implements ToJsonInterface {
  final String avatarPath;

  const SelectAvatarRequest(this.avatarPath);

  @override
  Map toJson() => {
        'avatar': avatarPath,
      };
}

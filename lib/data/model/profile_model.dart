import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/util/extension.dart';

class ProfileModel extends Profile implements ToJsonInterface {
  const ProfileModel(
    String id,
    String username,
    String firstName,
    String lastName,
  ) : super(
          id,
          username,
          firstName,
          lastName,
        );

  factory ProfileModel.fromJson(Map json) => ProfileModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('username'),
        json.parseValueAsString('first_name'),
        json.parseValueAsString('last_name'),
      );

  @override
  Map toJson() => {
        'id': this.id,
        'first_name': firstName,
        'last_name': lastName,
      };
}

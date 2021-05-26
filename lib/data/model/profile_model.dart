import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/profile.dart';

class ProfileModel extends Profile implements ToJsonInterface {
  const ProfileModel(String id, String username, String firstName, String lastName)
      : super(id, username, firstName, lastName);

  factory ProfileModel.fromJson(Map json) => ProfileModel(
        json['id'] == null ? '' : json['id'],
        json['username'] == null ? '' : json['username'],
        json['first_name'] == null ? '' : json['first_name'],
        json['last_name'] == null ? '' : json['last_name'],
      );

  @override
  Map toJson() => {
        'id': this.id,
        'first_name': firstName,
        'last_name': lastName,
      };
}

import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';

class ChallengeSimpleModel extends ChallengeSimple implements ToJsonInterface {
  const ChallengeSimpleModel(String id, String title, String description)
      : super(id, title, description);

  factory ChallengeSimpleModel.fromJson(Map json) => ChallengeSimpleModel(
        json['id'] == null ? '' : json['id'],
        json['title'] == null ? '' : json['title'],
        json['description'] == null ? '' : json['description'],
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}

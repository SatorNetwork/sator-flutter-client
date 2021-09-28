import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/util/extension.dart';

class ChallengeSimpleModel extends ChallengeSimple implements ToJsonInterface {
  const ChallengeSimpleModel(
    String id,
    String title,
    String description,
  ) : super(
          id,
          title,
          description,
        );

  factory ChallengeSimpleModel.fromJson(Map json) => ChallengeSimpleModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsString('description'),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}

import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/selected_show_challenges.dart';

class SelectedShowChallengesModel extends SelectedShowChallenges implements ToJsonInterface {
  const SelectedShowChallengesModel(String id, String title, String description)
      : super(id, title, description);

  factory SelectedShowChallengesModel.fromJson(Map json) => SelectedShowChallengesModel(
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

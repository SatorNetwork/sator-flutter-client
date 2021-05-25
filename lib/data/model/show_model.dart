import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show.dart';

class ShowModel extends Show implements ToJsonInterface {
  const ShowModel(String id, String title, String cover, bool hasNewEpisode)
      : super(id, title, cover, hasNewEpisode);

  factory ShowModel.fromJson(Map json) => ShowModel(
        json['id'] == null ? '' : json['id'],
        json['title'] == null ? '' : json['title'],
        json['cover'] == null ? '' : json['cover'],
        json['has_new_episode'] == null ? false : json['has_new_episode'],
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'cover': cover,
        'has_new_episode': hasNewEpisode,
      };
}

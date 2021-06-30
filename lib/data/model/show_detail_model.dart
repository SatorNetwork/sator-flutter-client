import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_detail.dart';

class ShowDetailModel extends ShowDetail implements ToJsonInterface {
  const ShowDetailModel(
      String id, String title, String cover, bool hasNewEpisode)
      : super(id, title, cover, hasNewEpisode);

  factory ShowDetailModel.fromJson(Map json) => ShowDetailModel(
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

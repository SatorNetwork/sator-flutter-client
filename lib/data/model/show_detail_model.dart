import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_detail.dart';

class ShowDetailModel extends ShowDetail implements ToJsonInterface {
  const ShowDetailModel(String id, String title, String cover,
      bool hasNewEpisode, category, description, int claps)
      : super(id, title, cover, hasNewEpisode, category, description, claps);

  factory ShowDetailModel.fromJson(Map json) => ShowDetailModel(
        json['id'] == null ? '' : json['id'],
        json['title'] == null ? '' : json['title'],
        json['cover'] == null ? '' : json['cover'],
        json['has_new_episode'] == null ? false : json['has_new_episode'],
        json['category'] == null ? '' : json['category'],
        json['description'] == null ? '' : json['description'],
        json['claps'] == null ? 0 : json['claps'],
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'cover': cover,
        'has_new_episode': hasNewEpisode,
        'category': category,
        'description': description,
        'claps': claps,
      };
}

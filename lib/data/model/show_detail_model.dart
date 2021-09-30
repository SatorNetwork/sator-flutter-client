import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/util/extension.dart';

class ShowDetailModel extends ShowDetail implements ToJsonInterface {
  const ShowDetailModel(
    String id,
    String title,
    String cover,
    bool hasNewEpisode,
    category,
    description,
    int claps,
    String realmTitle,
    String realmSubtitle,
    String watchUrl,
  ) : super(
          id,
          title,
          cover,
          hasNewEpisode,
          category,
          description,
          claps,
          realmTitle,
          realmSubtitle,
          watchUrl,
        );

  factory ShowDetailModel.fromJson(Map json) => ShowDetailModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsString('cover'),
        json.parseValueAsBool('has_new_episode'),
        json.parseValueAsString('category'),
        json.parseValueAsString('description'),
        json.parseValueAsInt('claps'),
        json.parseValueAsString('realms_title'),
        json.parseValueAsString('realms_subtitle'),
        json.parseValueAsString('watch'),
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
        'realms_title': realmTitle,
        'realms_subtitle': realmSubtitle,
        'watch': watchUrl,
      };
}

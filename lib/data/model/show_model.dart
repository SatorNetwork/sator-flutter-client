import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/util/extension.dart';

class ShowModel extends Show implements ToJsonInterface {
  const ShowModel(
    String id,
    String title,
    String cover,
    bool hasNewEpisode,
    bool hasNft,
  ) : super(
          id,
          title,
          cover,
          hasNewEpisode,
      hasNft,
        );

  factory ShowModel.fromJson(Map json) => ShowModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsString('cover'),
        json.parseValueAsBool('has_new_episode'),
        json.parseValueAsBool('has_nft'),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'cover': cover,
        'has_new_episode': hasNewEpisode,
        'has_nft': hasNft,
      };
}

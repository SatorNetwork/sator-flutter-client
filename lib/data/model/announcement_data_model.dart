import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/announcement_data.dart';
import 'package:satorio/util/extension.dart';

class AnnouncementDataModel extends AnnouncementData
    implements ToJsonInterface {
  const AnnouncementDataModel(
    String episodeId,
    String showId,
  ) : super(
          episodeId,
          showId,
        );

  factory AnnouncementDataModel.fromJson(Map json) => AnnouncementDataModel(
        json.parseValueAsString('episode_id'),
        json.parseValueAsString('show_id'),
      );

  @override
  Map toJson() => {
        'episode_id': episodeId,
        'show_id': showId,
      };
}

import 'package:satorio/data/model/announcement_data_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/announcement.dart';
import 'package:satorio/domain/entities/announcement_data.dart';
import 'package:satorio/util/extension.dart';

class AnnouncementModel extends Announcement implements ToJsonInterface {
  const AnnouncementModel(
    String id,
    String title,
    String description,
    int startsAt,
    int endsAt,
    String type,
    AnnouncementData? announcementData,
  ) : super(
          id,
          title,
          description,
          startsAt,
          endsAt,
          type,
          announcementData,
        );

  factory AnnouncementModel.fromJson(Map json) => AnnouncementModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsString('description'),
        json.parseValueAsInt('starts_at'),
        json.parseValueAsInt('ends_at'),
        json.parseValueAsString('type'),
        AnnouncementDataModel.fromJson(json['type_specific_params']),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'starts_at': startsAt,
        'ends_at': endsAt,
        'type': type,
        'type_specific_params': (announcementData as ToJsonInterface).toJson(),
      };
}

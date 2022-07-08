import 'package:satorio/domain/entities/announcement_data.dart';

class Announcement {
  final String id;
  final String title;
  final String description;
  final int startsAt;
  final int endsAt;
  final String type;
  final AnnouncementData? announcementData;

  const Announcement(this.id, this.title, this.description, this.startsAt,
      this.endsAt, this.type, this.announcementData);
}

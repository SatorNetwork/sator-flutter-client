import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';

class Realm {
  final ShowDetail showDetail;
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;

  const Realm(this.showDetail, this.showSeason, this.showEpisode);
}

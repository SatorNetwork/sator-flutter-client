import 'package:satorio/data/model/show_detail_model.dart';
import 'package:satorio/data/model/show_episode_model.dart';
import 'package:satorio/data/model/show_season_model.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/realm.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';

class RealmModel extends Realm implements ToJsonInterface {
  const RealmModel(
      ShowDetail showDetail, ShowSeason showSeason, ShowEpisode showEpisode)
      : super(showDetail, showSeason, showEpisode);

  factory RealmModel.fromJson(Map json) => RealmModel(
        ShowDetailModel.fromJson(json['show']),
        ShowSeasonModel.fromJson(json['season']),
        ShowEpisodeModel.fromJson(json['episode']),
      );

  @override
  Map toJson() => {
        'show': (showDetail as ToJsonInterface).toJson(),
        'season': (showSeason as ToJsonInterface).toJson(),
        'episode': (showEpisode as ToJsonInterface).toJson(),
      };
}

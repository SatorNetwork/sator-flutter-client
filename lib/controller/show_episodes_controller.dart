import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';

class ShowEpisodesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<ShowDetail> showDetailRx;
  final Rx<List<ShowSeason>> seasonsRx = Rx([]);

  late TabController tabController;

  ShowEpisodesController() {
    tabController = TabController(length: 0, vsync: this);

    ShowEpisodesArgument argument = Get.arguments as ShowEpisodesArgument;
    showDetailRx = Rx(argument.showDetail);

    refreshSeasons();
  }

  void back() {
    Get.back();
  }

  void toEpisodeDetail(ShowSeason showSeason, ShowEpisode showEpisode) {
    Get.to(
      () => ShowEpisodesRealmPage(),
      binding: ShowEpisodesRealmBinding(),
      arguments: ShowEpisodeRealmArgument(
        showDetailRx.value,
        showSeason,
        showEpisode,
      ),
    );
  }

  void refreshSeasons() {
    _satorioRepository
        .showSeasons(showDetailRx.value.id)
        .then((List<ShowSeason> seasons) {
      tabController = TabController(length: seasons.length, vsync: this);
      seasonsRx.value = seasons;
    });
  }
}

class ShowEpisodesArgument {
  final ShowDetail showDetail;

  const ShowEpisodesArgument(this.showDetail);
}

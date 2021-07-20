import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';

class ShowEpisodesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<ShowDetail?> showDetailRx = Rx(null);
  final Rx<List<ShowSeason>> seasonsRx = Rx([]);

  late TabController tabController;

  ShowEpisodesController() {
    tabController = TabController(length: 0, vsync: this);
  }

  void back() {
    Get.back();
  }

  void toEpisodeDetail(ShowSeason showSeason, ShowEpisode showEpisode) {
    if (showDetailRx.value != null) {
      Get.to(
            () => ShowEpisodesRealmPage(showDetailRx.value!, showSeason, showEpisode),
        binding: ShowEpisodesRealmBinding(),
      );
    }
  }

  void loadSeasonForShow(ShowDetail showDetail) {
    showDetailRx.value = showDetail;

    _satorioRepository
        .showSeasons(showDetail.id)
        .then((List<ShowSeason> seasons) {
      tabController = TabController(length: seasons.length, vsync: this);
      seasonsRx.value = seasons;
    });
  }

  void refreshSeasons() {
    if (showDetailRx.value == null) return;

    _satorioRepository
        .showSeasons(showDetailRx.value!.id)
        .then((List<ShowSeason> seasons) {
      tabController = TabController(length: seasons.length, vsync: this);
      seasonsRx.value = seasons;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';

class ShowDetailWithEpisodesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Show> showRx;
  final Rx<ShowDetail?> showDetailRx = Rx(null);
  final Rx<List<ShowSeason>> seasonsRx = Rx([]);

  late TabController tabController;

  final ScrollController scrollController = ScrollController();
  final RxDouble titleAlphaRx = 0.0.obs;

  ShowDetailWithEpisodesController() {
    tabController = TabController(length: 0, vsync: this);

    ShowDetailWithEpisodesArgument argument =
        Get.arguments as ShowDetailWithEpisodesArgument;
    showRx = Rx(argument.show);

    refreshShowData();
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  void refreshShowData() {
    _satorioRepository.showDetail(showRx.value.id).then((showDetail) {
      showDetailRx.value = showDetail;
    });

    _satorioRepository
        .showSeasons(showRx.value.id)
        .then((List<ShowSeason> seasons) {
      tabController = TabController(length: seasons.length, vsync: this);
      seasonsRx.value = seasons;
    });
  }

  void back() {
    Get.back();
  }

  void toNetflixDialog() {
    // if (showDetailRx.value != null) {
    //   Get.dialog(
    //     NetflixDialog(
    //       showDetailRx.value!.title,
    //     ),
    //   );
    // }
  }

  void toEpisodeDetail(ShowSeason showSeason, ShowEpisode showEpisode) {
    if (showDetailRx.value != null) {
      Get.to(
        () => ShowEpisodesRealmPage(),
        binding: ShowEpisodesRealmBinding(),
        arguments: ShowEpisodeRealmArgument(
          showDetailRx.value!,
          showSeason,
          showEpisode,
        ),
      );
    }
  }

  void _scrollListener() {
    double half = (scrollController.position.maxScrollExtent -
            scrollController.position.minScrollExtent) /
        2;
    double alpha = scrollController.position.pixels < half
        ? 0
        : (scrollController.position.pixels - half) / half;

    if (alpha < 0) alpha = 0;
    if (alpha > 1) alpha = 1;

    titleAlphaRx.value = alpha;
  }

  void toggleBottomSheet() {
    final double maxExtent = scrollController.position.maxScrollExtent;
    final double minExtent = scrollController.position.minScrollExtent;

    double half = (maxExtent - minExtent) / 2;
    double offset;
    if (scrollController.position.pixels < half) {
      // expand
      offset = maxExtent;
    } else {
      //collapse
      offset = minExtent;
    }
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

class ShowDetailWithEpisodesArgument {
  final Show show;

  const ShowDetailWithEpisodesArgument(this.show);
}

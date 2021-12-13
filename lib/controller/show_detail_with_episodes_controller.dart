import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDetailWithEpisodesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Show> showRx;
  final Rx<ShowDetail?> showDetailRx = Rx(null);
  final Rx<List<ShowSeason>> seasonsRx = Rx([]);

  late TabController tabController;

  final ScrollController scrollController = ScrollController();
  final RxDouble titleAlphaRx = 0.0.obs;

  final RxBool isClapsInProgress = false.obs;
  bool _isClapsActive = true;

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
    _loadShowDetail();
    _loadEpisodes();
  }

  void toShowNfts() {
    Get.to(
          () => NftListPage(),
      binding: NftListBinding(),
      arguments: NftListArgument(NftFilterType.Show, showRx.value.id),
    );
  }

  void back() {
    Get.back();
  }

  void watchShow() async {
    if (showDetailRx.value != null) {
      String url = showDetailRx.value!.watchUrl;
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
      //   Get.dialog(
      //     NetflixDialog(
      //       showDetailRx.value!.title,
      //     ),
      //   );
    }
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
          false
        ),
      );
    }
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

  void clap() {
    if (!_isClapsActive) return;
    if (isClapsInProgress.value) return;

    Future.value(true)
        .then((value) {
          isClapsInProgress.value = true;
          return value;
        })
        .then((value) => _satorioRepository.clapShow(showRx.value.id))
        .then((bool result) {
          if (result) {
            _loadShowDetail();
          }
          _isClapsActive = result;
          isClapsInProgress.value = false;
        })
        .catchError((value) {
          isClapsInProgress.value = false;
        });
  }

  void _loadShowDetail() {
    _satorioRepository.showDetail(showRx.value.id).then((showDetail) {
      showDetailRx.value = showDetail;
    });
  }

  void _loadEpisodes() {
    _satorioRepository
        .showSeasons(showRx.value.id)
        .then((List<ShowSeason> seasons) {
      tabController = TabController(length: seasons.length, vsync: this);
      seasonsRx.value = seasons;
    });
  }

  void _scrollListener() {
    double half = (scrollController.position.maxScrollExtent -
            scrollController.position.minScrollExtent) /
        2;
    double pixels = scrollController.position.pixels;
    double alpha = pixels < half ? 0 : (pixels - half) / half;

    if (alpha < 0) alpha = 0;
    if (alpha > 1) alpha = 1;

    titleAlphaRx.value = alpha;
  }
}

class ShowDetailWithEpisodesArgument {
  final Show show;

  const ShowDetailWithEpisodesArgument(this.show);
}

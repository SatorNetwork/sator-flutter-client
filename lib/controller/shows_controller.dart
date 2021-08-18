import 'package:get/get.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/controller/show_challenges_controller.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';

class ShowsController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();
  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final Rx<List<Show>> showsRx = Rx([]);

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadShows();
  }

  void loadShows() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .shows(page: _pageRx.value, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      showsRx.update((value) {
        if (value != null) value.addAll(shows);
      });
      _isAllLoadedRx.value = shows.isEmpty;
      _isLoadingRx.value = false;
      _pageRx.value = _pageRx.value + 1;
    }).catchError((value) {
      _isLoadingRx.value = false;
    });
  }

  void refreshShows() {
    if (_isLoadingRx.value) return;

    showsRx.value = [];
    _pageRx.value = _initialPage;
    _isAllLoadedRx.value = false;

    loadShows();
  }

  void toShowChallenges(Show show) {
    Get.to(
      () => ShowChallengesPage(),
      binding: ShowChallengesBinding(),
      arguments: ShowChallengesArgument(show),
    );
  }

  void toShowDetail(Show show) {
    // Get.to(
    //   () => ShowDetailPage(),
    //   binding: ShowDetailBinding(),
    //   arguments: ShowDetailArgument(show),
    // );
    Get.to(
      () => ShowDetailWithEpisodesPage(),
      binding: ShowDetailWithEpisodesBinding(),
      arguments: ShowDetailWithEpisodesArgument(show),
    );
  }
}

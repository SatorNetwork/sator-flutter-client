import 'package:get/get.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/binding/show_detail_binding.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';
import 'package:satorio/ui/page_widget/show_detail_page.dart';

class ShowsController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();
  final int _itemsPerPage = 10;

  final Rx<List<Show>> showsRx = Rx([]);

  static const int initialPage = 1;

  final RxInt _pageRx = initialPage.obs;
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
      _pageRx.value = _pageRx.value + initialPage;
    }).catchError((value) {
      _isLoadingRx.value = false;
    });
  }

  void refreshShows() {
    _pageRx.value = initialPage;
    showsRx.value = [];

    _satorioRepository
        .shows(page: _pageRx.value, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      showsRx.update((value) {
        if (value != null) value.addAll(shows);
      });
    });
  }

  void toShowChallenges(Show show) {
    Get.to(() => ShowChallengesPage(show), binding: ShowChallengesBinding());
  }

  void toShowDetail(Show show) {
    Get.to(() => ShowDetailPage(show), binding: ShowDetailBinding());
  }
}

import 'package:get/get.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/binding/show_detail_binding.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';
import 'package:satorio/ui/page_widget/show_detail_page.dart';

class ShowsController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> showsRx = Rx([]);

  final RxInt _pageRx = 1.obs;
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
        .shows(page: _pageRx.value, itemsPerPage: 5)
        .then((List<Show> shows) {
      print(shows.length.toString());
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

  void toShowChallenges(Show show) {
    Get.to(() => ShowChallengesPage(show), binding: ShowChallengesBinding());
  }

  void toShowDetail(Show show) {
    Get.to(() => ShowDetailPage(show), binding: ShowDetailBinding());
  }
}

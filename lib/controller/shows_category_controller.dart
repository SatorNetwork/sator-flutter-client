import 'package:get/get.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/binding/show_detail_binding.dart';
import 'package:satorio/controller/show_challenges_controller.dart';
import 'package:satorio/controller/show_detail_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';
import 'package:satorio/ui/page_widget/show_detail_page.dart';

class ShowsCategoryController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> showsRx = Rx([]);

  // final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  final Rx<String> titleRx = Rx('');

  void back() {
    Get.back();
  }

  void _loadShowsByCategoryName(String categoryName) {
    switch (categoryName) {
      case 'all':
        _loadAllShows();
        titleRx.value = 'All shows';
        break;
      case 'highest_rewarding':
        _satorioRepository
            .showsFromCategory('highest_rewarding')
            .then((List<Show> shows) {
          showsRx.value = shows;
        });
        titleRx.value = 'Highest Rewards';
        break;
      case 'most_socializing':
        _satorioRepository
            .showsFromCategory('most_socializing')
            .then((List<Show> shows) {
          showsRx.value = shows;
        });
        titleRx.value = 'Most Social';
        break;
      case 'newest_added':
        _satorioRepository
            .showsFromCategory('newest_added')
            .then((List<Show> shows) {
          showsRx.value = shows;
        });
        titleRx.value = 'Newest added';
        break;
    }
  }

  void _loadAllShows() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .shows(page: _pageRx.value)
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

  void toShowChallenges(Show show) {
    Get.to(
          () => ShowChallengesPage(),
      binding: ShowChallengesBinding(),
      arguments: ShowChallengesArgument(show),
    );
  }

  void toShowDetail(Show show) {
    Get.to(
          () => ShowDetailPage(),
      binding: ShowDetailBinding(),
      arguments: ShowDetailArgument(show),
    );
  }

  ShowsCategoryController() {
    ShowsCategoryArgument argument = Get.arguments;

    _loadShowsByCategoryName(argument.categoryName);
  }
}

class ShowsCategoryArgument {
  final String categoryName;

  const ShowsCategoryArgument(this.categoryName);
}

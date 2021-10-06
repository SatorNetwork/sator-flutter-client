import 'package:get/get.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';

class ShowsCategoryController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> showsRx = Rx([]);

  final int _itemsPerPage = 100;
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
        _loadCategory('highest_rewarding');
        titleRx.value = 'Highest Rewards';
        break;
      case 'most_socializing':
        _loadCategory('most_socializing');
        titleRx.value = 'Most Social';
        break;
      case 'newest_added':
        _loadCategory('newest_added');
        titleRx.value = 'Newest added';
        break;
    }
  }


  void _loadCategory(String categoryName) {
    _satorioRepository
        .showsFromCategory(categoryName, itemsPerPage: _itemsPerPage)
        .then((List<Show> shows) {
      showsRx.value = shows;
    });
  }

  void _loadAllShows() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository.shows(page: _pageRx.value, itemsPerPage: _itemsPerPage).then((List<Show> shows) {
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

  void toShowDetail(Show show) {
    Get.to(
      () => ShowDetailWithEpisodesPage(),
      binding: ShowDetailWithEpisodesBinding(),
      arguments: ShowDetailWithEpisodesArgument(show),
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

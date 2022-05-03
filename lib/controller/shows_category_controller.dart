import 'package:get/get.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/show_detail_with_episodes_binding.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/shows_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/domain/entities/show_category_type.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/show_detail_with_episodes_page.dart';

import 'nft_list_controller.dart';

class ShowsCategoryController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final String _categoryName;
  late final ShowsType showsType;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  final Rx<String> titleRx = Rx('');
  final Rx<List<Show>> showsRx = Rx([]);

  ShowsCategoryController() {
    ShowsCategoryArgument argument = Get.arguments;
    _categoryName = argument.categoryName;
    showsType = argument.showsType;

    if (argument.categoryTitle != null) {
      titleRx.value = argument.categoryTitle!;
    }

    loadShows();
    _updateTitle();
  }

  void back() {
    Get.back();
  }

  void loadShows() {
    switch (_categoryName) {
      case ShowCategoryType.all:
        _loadAllShows();
        break;
      case ShowCategoryType.withNfts:
        _loadShowsWithNfts();
        break;
      default:
        _loadCategory(_categoryName);
        break;
    }
  }

  void toShowDetail(Show show) {
    Get.to(
      () => ShowDetailWithEpisodesPage(),
      binding: ShowDetailWithEpisodesBinding(),
      arguments: ShowDetailWithEpisodesArgument(show),
    );
  }

  void toShowNfts(Show show) {
    Get.to(
      () => NftListPage(),
      binding: NftListBinding(),
      arguments: NftListArgument(NftFilterType.Show, show.id),
    );
  }

  void _updateTitle() {
    switch (_categoryName) {
      case ShowCategoryType.all:
        titleRx.value = 'txt_all_realms'.tr;
        break;
      case ShowCategoryType.highestRewarding:
        titleRx.value = 'txt_highest_rewards'.tr;
        break;
      case ShowCategoryType.mostSocializing:
        titleRx.value = 'txt_most_social'.tr;
        break;
      case ShowCategoryType.newestAdded:
        titleRx.value = 'txt_newest_added'.tr;
        break;
      case ShowCategoryType.popularMovies:
        titleRx.value = 'txt_popular_movies'.tr;
        break;
      case ShowCategoryType.musicRealms:
        titleRx.value = 'txt_music_realms'.tr;
        break;
    }
  }

  void _loadCategory(String categoryName) {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .showsFromCategory(
      categoryName,
      page: _pageRx.value,
      itemsPerPage: _itemsPerPage,
    )
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

  void _loadAllShows() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .shows(
      null,
      page: _pageRx.value,
      itemsPerPage: _itemsPerPage,
    )
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

  void _loadShowsWithNfts() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .shows(
      true,
      page: _pageRx.value,
      itemsPerPage: _itemsPerPage,
    )
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
}

class ShowsCategoryArgument {
  final String categoryName;
  final String? categoryTitle;
  final ShowsType showsType;

  const ShowsCategoryArgument(this.categoryName, this.categoryTitle, this.showsType);
}

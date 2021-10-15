import 'package:get/get.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';

class ReviewsController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Review>> reviewsRx = Rx([]);

  late final bool _isAllReviews;
  late final String _showDetailId;
  late final String _showEpisodeId;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  ReviewsController() {
    ReviewsArgument argument = Get.arguments as ReviewsArgument;

    _isAllReviews = argument.isAllReviews;
    _showDetailId = argument.showDetailId;
    _showEpisodeId = argument.showEpisodeId;

    loadReviews();
  }

  void loadReviews() {
    if (_isAllReviews) {
      _satorioRepository
          .getReviews(_showDetailId, _showEpisodeId)
          .then((List<Review> reviews) {
        reviewsRx.value = reviews;
      });
    } else {
      _loadUserReviews();
    }
  }

  void _loadUserReviews() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .getUserReviews(
      page: _pageRx.value,
      itemsPerPage: _itemsPerPage,
    )
        .then((List<Review> reviews) {
      reviewsRx.update((value) {
        if (value != null) value.addAll(reviews);
      });
      _isAllLoadedRx.value = reviews.isEmpty;
      _isLoadingRx.value = false;
      _pageRx.value = _pageRx.value + 1;
    }).catchError((value) {
      _isLoadingRx.value = false;
    });
  }

  void back() {
    Get.back();
  }
}

class ReviewsArgument{
  final String showDetailId;
  final String showEpisodeId;
  final bool isAllReviews;

  ReviewsArgument(this.showDetailId, this.showEpisodeId, this.isAllReviews);
}
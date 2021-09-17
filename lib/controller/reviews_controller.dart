import 'package:get/get.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';

class ReviewsController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Review>> reviewsRx = Rx([]);

  ReviewsController() {
    ReviewsArgument argument = Get.arguments as ReviewsArgument;

    _satorioRepository
        .getReviews(argument.showDetailId, argument.showEpisodeId)
        .then((List<Review> reviews) {
      reviewsRx.value = reviews;
    });
  }

  void back() {
    Get.back();
  }
}

class ReviewsArgument{
  final String showDetailId;
  final String showEpisodeId;

  ReviewsArgument(this.showDetailId, this.showEpisodeId);
}
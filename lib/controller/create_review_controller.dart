import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';

class CreateReviewController extends GetxController {
  static const int minValue = 1;
  static const int maxValue = 10;
  static const int initValue = 7;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;

  final RxInt rateRx = initValue.obs;
  final RxString titleRx = ''.obs;
  final RxString reviewRx = ''.obs;

  CreateReviewController() {
    CreateReviewArgument argument = Get.arguments as CreateReviewArgument;

    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);
  }

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(_titleListener);
    reviewController.addListener(_reviewListener);
  }

  @override
  void onClose() {
    titleController.removeListener(_titleListener);
    reviewController.removeListener(_reviewListener);
    super.onClose();
  }

  void back() {
    Get.back();
  }

  void _titleListener() {
    titleRx.value = titleController.text;
  }

  void _reviewListener() {
    reviewRx.value = reviewController.text;
  }
}

class CreateReviewArgument {
  final ShowDetail showDetail;
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;

  const CreateReviewArgument(
      this.showDetail, this.showSeason, this.showEpisode);
}

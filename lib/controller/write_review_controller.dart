import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class WriteReviewController extends GetxController {
  static const int minValue = 1;
  static const int maxValue = 10;
  static const int initValue = 7;

  final SatorioRepository _satorioRepository = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  late ValueListenable<Box<Profile>> profileListenable;

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;

  final Rx<WriteReviewState> stateRx = Rx(WriteReviewState.creating);
  final Rx<Profile?> profileRx = Rx(null);

  final RxInt rateRx = initValue.obs;
  final RxString titleRx = ''.obs;
  final RxString reviewRx = ''.obs;

  WriteReviewController() {
    WriteReviewArgument argument = Get.arguments as WriteReviewArgument;

    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);

    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(_titleListener);
    reviewController.addListener(_reviewListener);

    _profileListener();
    profileListenable.addListener(_profileListener);
  }

  @override
  void onClose() {
    titleController.removeListener(_titleListener);
    reviewController.removeListener(_reviewListener);
    super.onClose();
  }

  void back() {
    Get.back(result: false);
  }

  void toPreview() {
    stateRx.value = WriteReviewState.preview;
  }

  void editReview() {
    stateRx.value = WriteReviewState.creating;
  }

  void submitReview() {
    _satorioRepository
        .writeReview(
      showDetailRx.value.id,
      showEpisodeRx.value.id,
      rateRx.value,
      titleRx.value,
      reviewRx.value,
    )
        .then((bool result) {
      if (result) {
        Get.back(result: true);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('txt_review_write_success'.tr),
          ),
        );
      }
    });
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }

  void _titleListener() {
    titleRx.value = titleController.text.trim();
  }

  void _reviewListener() {
    reviewRx.value = reviewController.text.trim();
  }
}

class WriteReviewArgument {
  final ShowDetail showDetail;
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;

  const WriteReviewArgument(this.showDetail, this.showSeason, this.showEpisode);
}

enum WriteReviewState { creating, preview }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/transacting_tips_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/success_tip_dialog.dart';
import 'package:satorio/util/extension.dart';

class ReviewsController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Review>> reviewsRx = Rx([]);

  late final bool _isAllReviews;
  late final String _showDetailId;
  late final String _showEpisodeId;

  final TextEditingController amountController = TextEditingController();

  late final RxDouble amountRx = 0.0.obs;
  final RxBool isRequested = false.obs;

  late ValueListenable<Box<Profile>> profileListenable;
  late Profile profile;

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  final RxBool isTipsEnabledRx = true.obs;

  ReviewsController() {
    ReviewsArgument argument = Get.arguments as ReviewsArgument;

    _isAllReviews = argument.isAllReviews;
    _showDetailId = argument.showDetailId;
    _showEpisodeId = argument.showEpisodeId;

    if (GetPlatform.isIOS) {
      _satorioRepository
          .isTipsEnabled()
          .then((value) => isTipsEnabledRx.value = value);
    } else {
      isTipsEnabledRx.value = true;
    }

    loadReviews();
  }

  @override
  void onInit() async {
    super.onInit();
    amountController.addListener(_amountListener);

    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
    profile = profileListenable.value.getAt(0)!;
  }

  void toTransactingTipsDialog(String name, Review review) {
    Get.bottomSheet(
            TransactingTipsBottomSheet(
              this,
              review,
              name: name,
            ),
            isScrollControlled: true)
        .whenComplete(() {
      _clearAmount();
    });
  }

  void setTipAmount(String amount) {
    amountController.text = '$amount.00';
    amountRx.value = amountController.text.tryParse()!;
  }

  void sendReviewTip(Review review) {
    Future.value(true).then((value) {
      isRequested.value = true;
      return value;
    }).then((value) {
      _satorioRepository.sendReviewTip(review.id, amountRx.value).then((value) {
        if (value) {
          _toSuccessDialog(review.userName, review.userAvatar);
          _clearAmount();
          isRequested.value = false;
        }
      }).catchError((value) {
        isRequested.value = false;
      });
    });
  }

  void _clearAmount() {
    amountController.clear();
    amountRx.value = 0.0.abs();
  }

  void _amountListener() {
    double? amount = amountController.text.tryParse();
    if (amount != null) {
      amountRx.value = amount;
    }
  }

  void _toSuccessDialog(String name, String userAvatar) {
    Get.dialog(
      SuccessTipDialog(
        name,
        'txt_success_tip'.tr,
        'txt_success'.tr,
        amountRx.value,
        userAvatar,
        'txt_cool'.tr,
        icon: Icons.logout,
        onButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  void loadReviews() {
    if (_isAllReviews) {
      _loadAllReviews();
    } else {
      _loadUserReviews();
    }
  }

  void rateReview(String reviewId, String ratingType) {
    _satorioRepository.rateReview(reviewId, ratingType).then((value) {
      if (value) {
        if (_isAllReviews) {
          _satorioRepository
              .getReviews(_showDetailId, _showEpisodeId)
              .then((List<Review> reviews) {
            reviewsRx.value = reviews;
          });
        } else {
          _satorioRepository.getUserReviews().then((List<Review> reviews) {
            reviewsRx.value = reviews;
          });
        }
      }
    }).catchError((value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Something goes wrong'),
        ),
      );
    });
  }

  void _loadAllReviews() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    _isLoadingRx.value = true;

    _satorioRepository
        .getReviews(
      _showDetailId,
      _showEpisodeId,
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

//TODO: refactor, object
class ReviewsArgument {
  final String showDetailId;
  final String showEpisodeId;
  final bool isAllReviews;

  ReviewsArgument(this.showDetailId, this.showEpisodeId, this.isAllReviews);
}

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/binding/chat_binding.dart';
import 'package:satorio/binding/nft_item_binding.dart';
import 'package:satorio/binding/nft_list_binding.dart';
import 'package:satorio/binding/reviews_binding.dart';
import 'package:satorio/binding/show_episode_quiz_binding.dart';
import 'package:satorio/binding/video_youtube_binding.dart';
import 'package:satorio/binding/write_review_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/controller/chat_controller.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/controller/nft_item_controller.dart';
import 'package:satorio/controller/nft_list_controller.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/controller/reviews_controller.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/controller/video_youtube_controller.dart';
import 'package:satorio/data/model/last_seen_model.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/last_seen.dart';
import 'package:satorio/domain/entities/nft_filter_type.dart';
import 'package:satorio/domain/entities/nft_item.dart';
import 'package:satorio/domain/entities/paid_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/review.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/default_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/episode_realm_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/rate_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_expiring_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_paid_activation_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_unlock_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/transacting_tips_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/dialog_widget/success_tip_dialog.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';
import 'package:satorio/ui/page_widget/chat_page.dart';
import 'package:satorio/ui/page_widget/nft_item_page.dart';
import 'package:satorio/ui/page_widget/nft_list_page.dart';
import 'package:satorio/ui/page_widget/reviews_page.dart';
import 'package:satorio/ui/page_widget/show_episode_quiz_page.dart';
import 'package:satorio/ui/page_widget/video_youtube_page.dart';
import 'package:satorio/ui/page_widget/write_review_page.dart';
import 'package:satorio/util/extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'write_review_controller.dart';

class ShowEpisodeRealmController extends GetxController
    with BackToMainMixin, NonWorkingFeatureMixin, ValidationMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final int _itemsPerPage = 10;
  static const int _initialPage = 1;

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;
  final Rx<List<Review>> reviewsRx = Rx([]);
  final Rx<List<NftItem>> nftItemsRx = Rx([]);

  final RxBool isRequestedForUnlock = false.obs;

  final Rx<EpisodeActivation> activationRx = Rx(
    EpisodeActivation(false, null, null),
  );
  final RxInt attemptsLeftRx = 100500.obs;

  ScrollController scrollController = ScrollController();

  final TextEditingController amountController = TextEditingController();

  late final RxDouble amountRx = 0.0.obs;
  final RxBool isRequested = false.obs;
  final RxBool isEnabledRx = true.obs;

  late ValueListenable<Box<Profile>> profileListenable;
  late Profile profile;
  late bool isProfileRealm;

  late final DatabaseReference _messagesRef;
  late LastSeen lastSeen;
  DateTime? timestamp;
  late Rx<int> missedMessagesCountRx = Rx(0);
  late final DatabaseReference _timestampsRef;

  late Rx<bool> isMessagesRx = Rx(false);

  Query getMessageQuery() {
    return _messagesRef;
  }

  ShowEpisodeRealmController() {
    ShowEpisodeRealmArgument argument = Get.arguments;
    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);

    isProfileRealm = argument.isProfileRealm;

    _updateShowEpisode();
    _loadReviews();
    _loadNftItems();

    _checkActivation();
    _updateLeftAttempts();
  }

  @override
  void onInit() async {
    super.onInit();
    await _satorioRepository.initRemoteConfig();
    final String firebaseChild = await _satorioRepository.firebaseChatChild();
    final String firebaseUrl = await _satorioRepository.firebaseUrl();

    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    amountController.addListener(_amountListener);

    profile = profileListenable.value.getAt(0)!;

    _timestampsRef = FirebaseDatabase(databaseURL: firebaseUrl)
        .reference()
        .child(profile.id)
        .child(showEpisodeRx.value.id);

    _messagesRef = FirebaseDatabase.instance
        .reference()
        .child(firebaseChild)
        .child(showEpisodeRx.value.id);

    _messagesRef.once().then((DataSnapshot snapshot) {
      isMessagesRx.value = snapshot.value != null;
    });

    lastSeenInit();
  }

  @override
  void onClose() {
    amountController.removeListener(_amountListener);
    super.onClose();
  }

  void back() {
    if (isProfileRealm) {
      ProfileController profileController = Get.find();
      profileController.refreshPage();
    }
    Get.back();
  }

  Future lastSeenInit() async {
    //TODO: refactor
    await _timestampsRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        _timestampsRef.set(LastSeenModel(DateTime.now()).toJson());
        lastSeen = LastSeen(DateTime.now());
        return;
      }

      final json = snapshot.value as Map<dynamic, dynamic>;
      lastSeen = LastSeenModel.fromJson(json);
    });

    await _missedMessagesCounter();
  }

  Future _missedMessagesCounter() async {
    List missedMessages = [];
    await _messagesRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value == null) return;

      Map<dynamic, dynamic> values = snapshot.value;

      values.forEach((key, value) {
        if (DateTime.tryParse(value["createdAt"])!.microsecondsSinceEpoch >
            lastSeen.timestamp!.microsecondsSinceEpoch) {
          missedMessages.add(value);
        }
      });
      missedMessagesCountRx.value = missedMessages.length;
    });
  }

  void toWriteReview() async {
    final result = await Get.to(
      () => WriteReviewPage(),
      binding: WriteReviewBinding(),
      arguments: WriteReviewArgument(
        showDetailRx.value,
        showSeasonRx.value,
        showEpisodeRx.value,
      ),
    );

    if (result != null && result is bool && result) {
      _loadReviews();
      _updateShowEpisode();
    }
  }

  void rateReview(String reviewId, String ratingType) {
    isEnabledRx.value = false;

    Timer(Duration(milliseconds: 2000), () => isEnabledRx.value = true);

    _satorioRepository.rateReview(reviewId, ratingType).then((value) {
      if (value) {
        _satorioRepository
            .getReviews(showDetailRx.value.id, showEpisodeRx.value.id)
            .then((List<Review> reviews) {
          reviewsRx.value = reviews;
        });
      }
    }).catchError((value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Something goes wrong'),
        ),
      );
    });
  }

  void toChatPage() {
    Get.to(
      () => ChatPage(),
      binding: ChatBinding(),
      arguments: ChatArgument(
        _messagesRef,
        showDetailRx.value,
        showSeasonRx.value,
        showEpisodeRx.value,
      ),
    );
  }

  void toReviewsPage() {
    Get.to(
      () => ReviewsPage(),
      binding: ReviewsBinding(),
      arguments: ReviewsArgument(
        showDetailRx.value.id,
        showEpisodeRx.value.id,
        true,
      ),
    );
  }

  void toEpisodeRealmDialog() {
    Get.bottomSheet(
      EpisodeRealmBottomSheet(
        onQuizPressed: () {
          if (attemptsLeftRx.value > 0) {
            _loadQuizQuestion();
          } else {
            Get.dialog(
              DefaultDialog(
                'txt_oops'.tr,
                'txt_attempts_left_alert'.tr,
                'txt_ok'.tr,
              ),
            );
          }
        },
        onPaidUnlockPressed: () {
          _toRealmPaidActivationBottomSheet();
        },
        isZeroSeason: showSeasonRx.value.seasonNumber == 0,
      ),
      isScrollControlled: true,
      enableDrag: false,
      barrierColor: Colors.transparent,
    );
  }

  void toChallenge() {
    Get.to(
      () => ChallengePage(),
      binding: ChallengeBinding(),
      arguments: ChallengeArgument(showEpisodeRx.value.challengeId),
    );
  }

  void toRealmExpiringBottomSheet() {
    Get.bottomSheet(
      RealmExpiringBottomSheet(
        activationRx.value,
        (paidOption) {
          _paidUnlock(paidOption);
        },
      ),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
    );
  }

  void toRateBottomSheet() {
    Get.bottomSheet(
      RateBottomSheet(
        (int rate) {
          _rateEpisode(rate);
        },
        isZeroSeason: showSeasonRx.value.seasonNumber == 0,
      ),
    );
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
    Get.back();
    Get.dialog(
      SuccessTipDialog(
        name,
        'txt_success_tip'.tr,
        'txt_success'.tr,
        amountRx.value,
        userAvatar,
        'txt_cool'.tr,
        icon: Icons.check,
        onButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  void toNftsMarketplace() {
    if (Get.isRegistered<MainController>()) {
      MainController mainController = Get.find();
      mainController.selectedBottomTabIndex.value = MainController.TabNfts;
      backToMain();
    }
  }

  void toNftList() {
    Get.to(
      () => NftListPage(),
      binding: NftListBinding(),
      arguments: NftListArgument(NftFilterType.Episode, showEpisodeRx.value.id),
    );
  }

  void toNftItem(final NftItem nftItem) {
    Get.to(
      () => NftItemPage(),
      binding: NftItemBinding(),
      arguments: NftItemArgument(nftItem),
    );
  }

  void watchVideo() async {
    String url = showEpisodeRx.value.watch;
    if (YoutubePlayer.convertUrlToId(url) != null) {
      Get.to(
        () => VideoYoutubePage(),
        binding: VideoYoutubeBinding(),
        arguments: VideoYoutubeArgument(url),
      );
    } else {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    }
  }

  void activeTimeExpire() {
    _checkActivation();
    _updateShowEpisode();
  }

  void _checkActivation({bool showUnlock = false}) {
    _satorioRepository
        .isEpisodeActivated(showEpisodeRx.value.id)
        .then((EpisodeActivation episodeActivation) {
      activationRx.value = episodeActivation;
      if (showUnlock) {
        if (episodeActivation.isActive) {
          _toUnlockBottomSheet();
        }
      } else {
        if (episodeActivation.isActive &&
            episodeActivation.leftTimeInHours() < 2) {
          toRealmExpiringBottomSheet();
        }
      }
    });
  }

  void _loadQuizQuestion() {
    Future.value(true)
        .then((value) {
          isRequestedForUnlock.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository
              .showEpisodeQuizQuestion(showEpisodeRx.value.id),
        )
        .then((PayloadQuestion payloadQuestion) {
          isRequestedForUnlock.value = false;
          _toEpisodeQuiz(payloadQuestion);
        })
        .catchError(
          (value) {
            isRequestedForUnlock.value = false;
          },
        );
  }

  void _loadReviews() {
    _satorioRepository
        .getReviews(showDetailRx.value.id, showEpisodeRx.value.id)
        .then((List<Review> reviews) {
      reviewsRx.update((value) {
        if (value != null) {
          value.clear();
          value.addAll(reviews);
        }
      });
    });
  }

  void _loadNftItems() {
    _satorioRepository
        .nftsFiltered(
      page: _initialPage,
      itemsPerPage: _itemsPerPage,
      showIds: [showDetailRx.value.id]
    )
        .then(
      (List<NftItem> nftItems) {
        nftItemsRx.value = nftItems;
      },
    );
  }

  void _toEpisodeQuiz(PayloadQuestion payloadQuestion) async {
    final result = await Get.to(
      () => ShowEpisodeQuizPage(),
      binding: ShowEpisodeQuizBinding(),
      arguments: ShowEpisodeQuizArgument(
        showSeasonRx.value,
        showEpisodeRx.value,
        payloadQuestion,
      ),
    );

    if (result != null && result is bool) {
      _checkActivation(showUnlock: true);
      _updateShowEpisode();
    }

    _updateLeftAttempts();
  }

  void _toRealmPaidActivationBottomSheet() {
    Get.bottomSheet(
      RealmPaidActivationBottomSheet(
        (paidOption) {
          _paidUnlock(paidOption);
        },
      ),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
    );
  }

  void _paidUnlock(PaidOption paidOption) {
    Future.value(true)
        .then((value) {
          isRequestedForUnlock.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.paidUnlockEpisode(
            showEpisodeRx.value.id,
            paidOption.label,
          ),
        )
        .then(
          (EpisodeActivation episodeActivation) {
            isRequestedForUnlock.value = false;
            activationRx.value = episodeActivation;
            if (episodeActivation.isActive) {
              _toUnlockBottomSheet();
              _updateShowEpisode();
            }
          },
        )
        .catchError(
          (value) {
            isRequestedForUnlock.value = false;
          },
        );
  }

  void _toUnlockBottomSheet() {
    Get.bottomSheet(
      RealmUnlockBottomSheet(),
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      enableDrag: false,
    );
  }

  void _rateEpisode(int rate) {
    _satorioRepository
        .rateEpisode(showDetailRx.value.id, showEpisodeRx.value.id, rate)
        .then(
      (result) {
        if (result) {
          _updateShowEpisode();
          Get.bottomSheet(
            DefaultBottomSheet(
              'txt_success'.tr,
              'txt_rate_success'.tr.format([rate]),
              'txt_awesome'.tr,
              icon: Icons.check_rounded,
              onPressed: () {
                Get.back();
              },
            ),
          );
        }
      },
    );
  }

  void _updateShowEpisode() {
    _satorioRepository
        .showEpisode(showDetailRx.value.id, showEpisodeRx.value.id)
        .then(
      (ShowEpisode showEpisode) {
        showEpisodeRx.value = showEpisode;
      },
    );
  }

  void _updateLeftAttempts() {
    _satorioRepository.showEpisodeAttemptsLeft(showEpisodeRx.value.id).then(
      (leftAttempts) {
        attemptsLeftRx.value = leftAttempts;
      },
    );
  }
}

class ShowEpisodeRealmArgument {
  final ShowDetail showDetail;
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;
  final bool isProfileRealm;

  const ShowEpisodeRealmArgument(
    this.showDetail,
    this.showSeason,
    this.showEpisode,
    this.isProfileRealm,
  );
}

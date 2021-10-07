import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/binding/chat_binding.dart';
import 'package:satorio/binding/reviews_binding.dart';
import 'package:satorio/binding/show_episode_quiz_binding.dart';
import 'package:satorio/binding/write_review_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/controller/chat_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/reviews_controller.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/data/model/last_seen_model.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/last_seen.dart';
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
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';
import 'package:satorio/ui/page_widget/chat_page.dart';
import 'package:satorio/ui/page_widget/reviews_page.dart';
import 'package:satorio/ui/page_widget/show_episode_quiz_page.dart';
import 'package:satorio/ui/page_widget/write_review_page.dart';
import 'package:satorio/util/extension.dart';

import 'write_review_controller.dart';

class ShowEpisodeRealmController extends GetxController
    with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;
  final Rx<List<Review>> reviewsRx = Rx([]);

  final Rx<EpisodeActivation> activationRx = Rx(
    EpisodeActivation(false, null, null),
  );
  final RxInt attemptsLeftRx = 100500.obs;

  ScrollController scrollController = ScrollController();

  late ValueListenable<Box<Profile>> profileListenable;
  late Profile profile;

  late final DatabaseReference _messagesRef;
  late LastSeen lastSeen;
  DateTime? timestamp;
  late Rx<int> missedMessagesCountRx = Rx(0);
  late final DatabaseReference _timestampsRef;
  //TODO: refactor
  static const String DATABASE_URL =
      'https://sator-f44d6-timestamp.firebaseio.com/';

  late Rx<bool> isMessagesRx = Rx(false);

  Query getMessageQuery() {
    return _messagesRef;
  }

  ShowEpisodeRealmController() {
    ShowEpisodeRealmArgument argument = Get.arguments;
    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);

    this.profileListenable =
    _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;

    profile = profileListenable.value.getAt(0)!;

    _timestampsRef = FirebaseDatabase(databaseURL: DATABASE_URL)
        .reference()
        .child(profile.id)
        .child(argument.showEpisode.id);

    _messagesRef = FirebaseDatabase.instance
        .reference()
        .child('test')
        .child(argument.showEpisode.id);

    _messagesRef.once().then((DataSnapshot snapshot) {
      isMessagesRx.value = snapshot.value != null;
      print(isMessagesRx.value);
    });

    _updateShowEpisode();
    _loadReviews();
    lastSeenInit();

    _checkActivation();
    _updateLeftAttempts();
  }

  void back() {
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
    _satorioRepository
        .showEpisodeQuizQuestion(showEpisodeRx.value.id)
        .then((PayloadQuestion payloadQuestion) {
      _toEpisodeQuiz(payloadQuestion);
    });
  }

  void _loadReviews() {
    _satorioRepository
        .getReviews(showDetailRx.value.id, showEpisodeRx.value.id)
        .then((List<Review> reviews) {
      reviewsRx.value = reviews;
    });
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
      _updateLeftAttempts();
    }
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
    _satorioRepository
        .paidUnlockEpisode(
      showEpisodeRx.value.id,
      paidOption.label,
    )
        .then(
      (EpisodeActivation episodeActivation) {
        activationRx.value = episodeActivation;
        if (episodeActivation.isActive) {
          _toUnlockBottomSheet();
          _updateShowEpisode();
        }
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

  const ShowEpisodeRealmArgument(
    this.showDetail,
    this.showSeason,
    this.showEpisode,
  );
}

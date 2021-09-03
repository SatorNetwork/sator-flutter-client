import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/binding/chat_binding.dart';
import 'package:satorio/binding/show_episode_quiz_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/controller/chat_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';
import 'package:satorio/domain/entities/episode_activation.dart';
import 'package:satorio/domain/entities/paid_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/default_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/rate_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_expiring_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/realm_paid_activation_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/episode_realm_dialog.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';
import 'package:satorio/ui/page_widget/chat_page.dart';
import 'package:satorio/ui/page_widget/show_episode_quiz_page.dart';
import 'package:satorio/util/extension.dart';

class ShowEpisodeRealmController extends GetxController
    with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<ShowDetail> showDetailRx;
  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;

  final Rx<EpisodeActivation> activationRx = Rx(
    EpisodeActivation(false, null, null),
  );

  ScrollController scrollController = ScrollController();

  late final DatabaseReference _messagesRef;

  late Rx<bool> isMessagesRx = Rx(false);

  Query getMessageQuery() {
    return _messagesRef;
  }

  ShowEpisodeRealmController() {
    ShowEpisodeRealmArgument argument = Get.arguments;
    showDetailRx = Rx(argument.showDetail);
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);
    _messagesRef = FirebaseDatabase.instance
        .reference()
        .child('test')
        .child(argument.showEpisode.id);

    _messagesRef.once().then((DataSnapshot snapshot) {
      isMessagesRx.value = snapshot.value != null;
      print(isMessagesRx.value);
    });

    _checkActivation();
  }

  void back() {
    Get.back();
  }

  void toChatPage() {
    Get.to(
      () => ChatPage(),
      binding: ChatBinding(),
      arguments: ChatArgument(_messagesRef, showDetailRx.value,
          showSeasonRx.value, showEpisodeRx.value),
    );
  }

  void toEpisodeRealmDialog() {
    Get.dialog(
      EpisodeRealmDialog(
        onQuizPressed: () {
          _loadQuizQuestion();
        },
        onPaidUnlockPressed: () {
          _toRealmPaidActivationBottomSheet();
        },
      ),
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
    );
  }

  void toRateBottomSheet() {
    Get.bottomSheet(
      RateBottomSheet(
        (int rate) {
          _rateEpisode(rate);
        },
      ),
    );
  }

  void _checkActivation() {
    _satorioRepository
        .isEpisodeActivated(showEpisodeRx.value.id)
        .then((EpisodeActivation episodeActivation) {
      activationRx.value = episodeActivation;
      if (episodeActivation.isActive && episodeActivation.leftHours() < 2) {
        toRealmExpiringBottomSheet();
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
      _checkActivation();
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
          Get.bottomSheet(
            DefaultBottomSheet(
              'txt_success'.tr,
              'txt_realm_extend_success'.tr.format([paidOption.hours]),
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

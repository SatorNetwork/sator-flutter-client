import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_mixin.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class ShowEpisodeQuizController extends GetxController with BackMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<ShowSeason?> showSeasonRx = Rx(null);
  final Rx<ShowEpisode?> showEpisodeRx = Rx(null);

  final Rx<PayloadQuestion?> questionRx = Rx(null);
  final Rx<String> answerIdRx = Rx('');
  final Rx<bool> isAnswerSentRx = Rx(false);
  final CountDownController countdownController = CountDownController();

  void loadValidationQuestion(ShowSeason showSeason, ShowEpisode showEpisode) {
    showSeasonRx.value = showSeason;
    showEpisodeRx.value = showEpisode;

    _satorioRepository
        .showEpisodeQuizQuestion(showEpisode.id)
        .then((PayloadQuestion payloadQuestion) {
      _updatePayloadQuestion(payloadQuestion, true);
    });
  }

  void _updatePayloadQuestion(PayloadQuestion payloadQuestion, bool restart) {
    answerIdRx.value = '';
    isAnswerSentRx.value = false;
    questionRx.value = payloadQuestion;
    if (restart)
      countdownController.restart(duration: payloadQuestion.timeForAnswer);
  }

  void selectAnswer(PayloadAnswerOption answerOption) {
    if (!isAnswerSentRx.value) {
      answerIdRx.value = answerOption.answerId;
      _sendAnswer();
    }
  }

  void _sendAnswer() {
    if (questionRx.value != null) {
      if (answerIdRx.value.isNotEmpty && !isAnswerSentRx.value) {
        _satorioRepository
            .showEpisodeQuizAnswer(
                questionRx.value!.questionId, answerIdRx.value)
            .then((bool result) {
          isAnswerSentRx.value = true;
          if (result) {
            if (Get.isRegistered<ShowEpisodeRealmController>()) {
              ShowEpisodeRealmController showEpisodeRealmController =
                  Get.find();
              showEpisodeRealmController.isRealmActivatedRx.value = true;
              Get.back(closeOverlays: true);
            }
          } else {
            Get.dialog(
              DefaultDialog(
                'txt_oops'.tr,
                'txt_wrong_answer'.tr,
                'txt_back_home'.tr,
                icon: Icons.close_rounded,
                onPressed: () {
                  Get.until((route) => !Get.isOverlaysOpen);
                  Get.until((route) =>
                      Get.currentRoute == '/() => ShowEpisodesRealmPage');
                },
              ),
              barrierDismissible: false,
            );
          }
        });
      }
    }
  }
}

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class ShowEpisodeQuizController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<ShowSeason> showSeasonRx;
  late final Rx<ShowEpisode> showEpisodeRx;

  final Rx<PayloadQuestion?> questionRx = Rx(null);
  final Rx<String> answerIdRx = Rx('');
  final Rx<bool> isAnswerSentRx = Rx(false);
  final CountDownController countdownController = CountDownController();

  ShowEpisodeQuizController() {
    ShowEpisodeQuizArgument argument = Get.arguments as ShowEpisodeQuizArgument;
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);

    _satorioRepository
        .showEpisodeQuizQuestion(argument.showEpisode.id)
        .then((PayloadQuestion payloadQuestion) {
      _updatePayloadQuestion(payloadQuestion);
    });
  }

  void back() {
    Get.back();
  }

  void _updatePayloadQuestion(PayloadQuestion payloadQuestion) {
    answerIdRx.value = '';
    isAnswerSentRx.value = false;
    questionRx.value = payloadQuestion;
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
            Get.back(closeOverlays: true, result: true);
          } else {
            Get.dialog(
              DefaultDialog(
                'txt_oops'.tr,
                'txt_wrong_answer'.tr,
                'txt_ok'.tr,
                icon: Icons.sentiment_dissatisfied_rounded,
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

  void timeExpire() {
    Get.dialog(
      DefaultDialog(
        'txt_oops'.tr,
        'txt_time_expire'.tr,
        'txt_ok'.tr,
        icon: Icons.sentiment_dissatisfied_rounded,
        onPressed: () {
          Get.until((route) => !Get.isOverlaysOpen);
          Get.until(
              (route) => Get.currentRoute == '/() => ShowEpisodesRealmPage');
        },
      ),
      barrierDismissible: false,
    );
  }
}

class ShowEpisodeQuizArgument {
  final ShowSeason showSeason;
  final ShowEpisode showEpisode;

  const ShowEpisodeQuizArgument(this.showSeason, this.showEpisode);
}

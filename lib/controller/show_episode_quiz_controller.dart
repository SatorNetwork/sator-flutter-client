import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/util/getx_extension.dart';

class ShowEpisodeQuizController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<ShowSeason?> showSeasonRx;
  late final Rx<ShowEpisode?> showEpisodeRx;
  late final Rx<PayloadQuestion> questionRx;

  final Rx<String> answerIdRx = Rx('');
  final Rx<bool> isAnswerSentRx = Rx(false);
  final CountDownController countdownController = CountDownController();

  ShowEpisodeQuizController() {
    ShowEpisodeQuizArgument argument = Get.arguments as ShowEpisodeQuizArgument;
    showSeasonRx = Rx(argument.showSeason);
    showEpisodeRx = Rx(argument.showEpisode);
    questionRx = Rx(argument.payloadQuestion);
  }

  void back() {
    Get.back();
  }

  void selectAnswer(PayloadAnswerOption answerOption) {
    if (!isAnswerSentRx.value) {
      answerIdRx.value = answerOption.answerId;
      _sendAnswer();
    }
  }

  void _sendAnswer() {
    if (answerIdRx.value.isNotEmpty && !isAnswerSentRx.value) {
      _satorioRepository
          .showEpisodeQuizAnswer(questionRx.value.questionId, answerIdRx.value)
          .then(
        (bool result) {
          isAnswerSentRx.value = true;
          countdownController.pause();
          if (result) {
            Get.back(closeOverlays: true, result: true);
          } else {
            _showSnackbar('txt_oops'.tr, 'txt_wrong_answer'.tr);
          }
        },
      );
    }
  }

  void timeExpire() {
    if (isAnswerSentRx.value) return;

    isAnswerSentRx.value = true;
    _showSnackbar('txt_oops'.tr, 'txt_time_expire'.tr);
  }

  void _showSnackbar(String title, String message) {
    Get.snackbarMessage(
      title,
      message,
      snackbarStatus: (SnackbarStatus? status) {
        if (status == SnackbarStatus.CLOSED) {
          Get.back(closeOverlays: true);
        }
      },
    );
  }
}

class ShowEpisodeQuizArgument {
  final ShowSeason? showSeason;
  final ShowEpisode? showEpisode;
  final PayloadQuestion payloadQuestion;

  const ShowEpisodeQuizArgument(
    this.showSeason,
    this.showEpisode,
    this.payloadQuestion,
  );
}

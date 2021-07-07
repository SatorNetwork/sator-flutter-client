import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';

class ShowEpisodeQuizController extends GetxController {
  Rx<PayloadQuestion?> questionRx = Rx(null);
  Rx<String> answerIdRx = Rx('');
  Rx<bool> isAnswerSentRx = Rx(false);
  CountDownController countdownController = CountDownController();

  ShowEpisodeQuizController() {
    // load episode quiz question
  }

  void updatePayloadQuestion(PayloadQuestion payloadQuestion, bool restart) {
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
        // send answer
      }
    }
  }
}

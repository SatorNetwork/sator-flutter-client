import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';

class QuizQuestionController extends GetxController {
  Rx<PayloadQuestion> questionRx = Rx(null);
  Rx<String> answerIdRx = Rx('');
  Rx<bool> isAnswerSentRx = Rx(false);
  CountDownController countdownController = CountDownController();

  QuizController quizController = Get.find();

  void updatePayloadQuestion(PayloadQuestion payloadQuestion) {
    answerIdRx.value = '';
    isAnswerSentRx.value = false;
    questionRx.value = payloadQuestion;
    countdownController.restart(duration: payloadQuestion.timeForAnswer);
  }

  void sendAnswer() {
    if (answerIdRx.value.isNotEmpty && isAnswerSentRx.value) {
      //
    }
  }
}

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_answer_option.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';

class QuizQuestionController extends GetxController {
  Rx<PayloadQuestion?> questionRx = Rx(null);
  Rx<String> answerIdRx = Rx('');
  CountDownController countdownController = CountDownController();

  QuizController quizController = Get.find();

  void updatePayloadQuestion(PayloadQuestion payloadQuestion, bool restart) {
    answerIdRx.value = '';
    questionRx.value = payloadQuestion;
    if (restart)
      countdownController.restart(duration: payloadQuestion.timeForAnswer);
  }

  void selectAnswer(PayloadAnswerOption answerOption) {
    answerIdRx.value = answerOption.answerId;
    _sendAnswer();
  }

  void _sendAnswer() {
    if (questionRx.value != null && answerIdRx.value.isNotEmpty) {
      quizController.sendAnswer(questionRx.value!.questionId, answerIdRx.value);
    }
  }
}

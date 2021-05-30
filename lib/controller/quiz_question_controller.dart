import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_question.dart';

class QuizQuestionController extends GetxController {
  Rx<PayloadQuestion> questionRx = Rx(null);
  QuizController quizController = Get.find();

  void updatePayloadQuestion(PayloadQuestion payloadQuestion) {
    // TODO: reset answer selection etc
    questionRx.value = payloadQuestion;
  }
}

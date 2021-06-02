import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';

class QuizResultController extends GetxController {
  Rx<PayloadChallengeResult> resultRx = Rx(null);
  QuizController quizController = Get.find();

  void back() {
    Get.back();
  }
}

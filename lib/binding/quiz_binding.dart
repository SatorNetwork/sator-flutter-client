import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/controller/quiz_counter_controller.dart';
import 'package:satorio/controller/quiz_lobby_controller.dart';
import 'package:satorio/controller/quiz_question_controller.dart';
import 'package:satorio/controller/quiz_result_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(() => QuizController());

    Get.put<QuizLobbyController>(QuizLobbyController());
    Get.put<QuizCounterController>(QuizCounterController());
    Get.put<QuizQuestionController>(QuizQuestionController());
    Get.put<QuizResultController>(QuizResultController());
  }
}

import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';

class QuizLobbyController extends GetxController {
  Rx<List<PayloadUser>> usersRx = Rx([]);
  QuizController quizController = Get.find();
}

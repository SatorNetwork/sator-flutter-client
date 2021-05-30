import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/payload/payload_user.dart';

class QuizLobbyController extends GetxController {
  Rx<List<PayloadUser>> usersRx = Rx([
    PayloadUser('1', '@king'),
    PayloadUser('2', '@LordDoink'),
    PayloadUser('3', '@PapaRachet'),
    PayloadUser('4', '@TvNerdGal'),
    PayloadUser('5', '@IknomrthnY'),
    PayloadUser('6', '@quizQueen'),
    PayloadUser('7', '@LordDoink'),
    PayloadUser('8', '@PapaRachet'),
    PayloadUser('9', '@TvNerdGal'),
  ]);
  QuizController quizController = Get.find();
}

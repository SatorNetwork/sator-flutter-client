import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';

class QuizController extends GetxController {
  Challenge challenge;

  Rx<String> childPageWidget = Rx('');

  void setChallenge(Challenge challenge) {
    this.challenge = challenge;
  }
}

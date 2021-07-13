import 'package:get/get.dart';
import 'package:satorio/binding/quiz_binding.dart';
import 'package:satorio/controller/mixin/back_mixin.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/quiz_page.dart';

class ChallengeController extends GetxController with BackMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Challenge?> challengeRx = Rx(null);

  void loadChallenge(String challengeId) {
    _satorioRepository.challenge(challengeId).then((Challenge challenge) {
      challengeRx.value = challenge;
    });
  }

  void playChallenge() {
    if (challengeRx.value != null) {
      Get.to(() => QuizPage(challengeRx.value!), binding: QuizBinding());
    }
  }
}

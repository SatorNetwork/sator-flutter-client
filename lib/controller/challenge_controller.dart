import 'package:get/get.dart';
import 'package:satorio/binding/quiz_binding.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/quiz_page.dart';

class ChallengeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Challenge?> challengeRx = Rx(null);

  ChallengeController() {
    ChallengeArgument argument = Get.arguments as ChallengeArgument;
    _satorioRepository
        .challenge(argument.challengeId)
        .then((Challenge challenge) {
      challengeRx.value = challenge;
    });
  }

  void back() {
    Get.back();
  }

  void playChallenge() {
    if (challengeRx.value != null) {
      _satorioRepository.quizSocketUrl(challengeRx.value!.id).then(
        (socketUrl) {
          Get.to(
            () => QuizPage(),
            binding: QuizBinding(),
            arguments: QuizArgument(
              challengeRx.value!,
              socketUrl,
            ),
          );
        },
      );
    }
  }
}

class ChallengeArgument {
  final String challengeId;

  const ChallengeArgument(this.challengeId);
}

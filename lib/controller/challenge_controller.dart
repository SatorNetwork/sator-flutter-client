import 'package:get/get.dart';
import 'package:satorio/binding/quiz_binding.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/quiz_page.dart';

class ChallengeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Challenge?> challengeRx = Rx(null);
  final RxBool isRequested = false.obs;

  ChallengeController() {
    ChallengeArgument argument = Get.arguments as ChallengeArgument;
    _reloadChallenge(argument.challengeId);
  }

  void back() {
    Get.back();
  }

  void playChallenge() {
    if (challengeRx.value == null) return;

    Future.value(true)
        .then((value) {
          isRequested.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.quizSocketUrl(challengeRx.value!.id),
        )
        .then(
          (socketUrl) {
            isRequested.value = false;
            _toQuiz(socketUrl);
          },
        )
        .catchError((value) {
          isRequested.value = false;
        });
  }

  void _reloadChallenge(String challengeId) {
    _satorioRepository.challenge(challengeId).then((Challenge challenge) {
      challengeRx.value = challenge;
    });
  }

  void _toQuiz(String socketUrl) async {
    final result = await Get.to(
      () => QuizPage(),
      binding: QuizBinding(),
      arguments: QuizArgument(
        challengeRx.value!,
        socketUrl,
      ),
    );
    if (challengeRx.value != null) {
      _reloadChallenge(challengeRx.value!.id);
    }
  }
}

class ChallengeArgument {
  final String challengeId;

  const ChallengeArgument(this.challengeId);
}

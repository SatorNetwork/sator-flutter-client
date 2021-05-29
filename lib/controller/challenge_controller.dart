import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ChallengeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Challenge> challengeRx = Rx(null);

  void loadChallenge(String challengeId) {
    _satorioRepository.challenge(challengeId).then((Challenge challenge) {
      challengeRx.value = challenge;
    });
  }

  void back() {
    Get.back();
  }

  void playChallenge() {
    //TODO : start play challenge
  }
}

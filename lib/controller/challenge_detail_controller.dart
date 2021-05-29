import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ChallengeDetailController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<ChallengeDetail> challengeDetailRx = Rx(null);

  void loadChallengeDetail(String challengeId) {
    _satorioRepository
        .challenge(challengeId)
        .then((ChallengeDetail challengeDetail) {
      challengeDetailRx.value = challengeDetail;
    });
  }

  void back() {
    Get.back();
  }

  void playChallenge() {
    //TODO : start play challenge
  }
}

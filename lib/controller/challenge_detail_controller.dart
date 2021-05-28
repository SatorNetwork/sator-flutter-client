import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ChallengeDetailController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<ChallengeDetail> challengeDetailRx = Rx(null);

  void loadChallengeDetail(String challengeId) {
    // _satorioRepository
    //     .challenge(challengeId)
    //     .then((ChallengeDetail challengeDetail) {
    //   challengeDetailRx.value = challengeDetail;
    // });
    Future.delayed(Duration(seconds: 1)).then((value) {
      challengeDetailRx.value = ChallengeDetail(
          'f4f78cac-5db6-4ecc-ad13-5877705f3126',
          'Challenge name',
          'Fast Questions! More detailed description about this challenge here. We can use couple senteces.',
          '250 SAO',
          10,
          '15 sec',
          'http://localhost:8080/challenges/{challenge_id}/play');
    });
  }

  void back() {
    Get.back();
  }

  void playChallenge() {
    //TODO : start play challenge
  }
}

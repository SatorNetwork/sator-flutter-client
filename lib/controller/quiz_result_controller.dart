import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';

class QuizResultController extends GetxController {
  Rx<PayloadChallengeResult?> resultRx = Rx(null);
  Rx<bool> isRequested = Rx(false);

  QuizController quizController = Get.find();
  SatorioRepository _satorioRepository = Get.find();

  final RxString claimText = ''.obs;

  QuizResultController() {
    _satorioRepository.claimRewardsText().then((value) {
      claimText.value = value;
    });
  }

  void claimRewards() {
    Future.value(true)
        .then(
          (value) {
            isRequested.value = true;
            return value;
          },
        )
        .then((value) => _satorioRepository.claimReward())
        .then(
          (ClaimReward claimReward) {
            isRequested.value = false;
            Get.bottomSheet(
              ClaimRewardsBottomSheet(
                claimReward,
                () {
                  quizController.backToEpisode();
                },
              ),
            );
          },
        )
        .catchError(
          (value) {
            isRequested.value = false;
          },
        );
  }
}

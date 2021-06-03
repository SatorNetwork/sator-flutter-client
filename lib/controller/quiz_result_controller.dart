import 'package:get/get.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

// import 'package:satorio/domain/entities/payload/payload_winner.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';

class QuizResultController extends GetxController {
  Rx<PayloadChallengeResult> resultRx = Rx(null);

  SatorioRepository _satorioRepository = Get.find();

  void claimRewards() {
    _satorioRepository.claimReward().then((ClaimReward claimReward) {
      if (claimReward != null)
        Get.bottomSheet(
          ClaimRewardsBottomSheet(claimReward),
        );
    });
  }

  void backToMain() {
    Get.until((route) => Get.currentRoute == '/() => MainPage');
  }
}

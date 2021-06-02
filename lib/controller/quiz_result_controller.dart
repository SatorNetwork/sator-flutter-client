import 'package:get/get.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/data/model/payload/payload_winner_model.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
// import 'package:satorio/domain/entities/payload/payload_winner.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';

class QuizResultController extends GetxController {
  Rx<PayloadChallengeResult> resultRx = Rx(null);
  QuizController quizController = Get.find();

  void claimRewards() {
    // TODO: replace
    Get.bottomSheet(ClaimRewardsBottomSheet(PayloadWinnerModel("kdkdkd", "test", "83.33 SAO")));
  }

  void backToMain() {
    Get.until((route) => Get.currentRoute == '/() => MainPage');
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/controller/quiz_controller.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/payload/payload_player.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';
import 'package:satorio/ui/bottom_sheet_widget/quiz_winner_bottom_sheet.dart';

class QuizResultController extends GetxController {
  final Rx<PayloadChallengeResult?> resultRx = Rx(null);
  final Rx<bool> isRequested = Rx(false);

  QuizController quizController = Get.find();
  SatorioRepository _satorioRepository = Get.find();

  final RxString claimText = ''.obs;
  final RxBool isWinnerScoresEnabledRx = false.obs;

  QuizResultController() {
    _satorioRepository.claimRewardsText().then((value) {
      claimText.value = value;
    });

    _satorioRepository
        .isWinnerScoresEnabled()
        .then((value) => isWinnerScoresEnabledRx.value = value);
  }

  void updateQuizResult(PayloadChallengeResult payloadChallengeResult) {
    resultRx.value = payloadChallengeResult;

    if (isWinnerScoresEnabledRx.value) {
      _checkIsUserWinner(payloadChallengeResult.winners);
    }
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

  void _checkIsUserWinner(List<PayloadPlayer> winners) {
    final Profile profile = (_satorioRepository.profileListenable()
            as ValueListenable<Box<Profile>>)
        .value
        .getAt(0)!;

    final index = winners.indexWhere((element) => element.userId == profile.id);
    if (index >= 0) {
      final player = winners[index];
      Get.bottomSheet(
        QuizWinnerBottomSheet(player.prize, player.bonus),
      );
    }
  }
}

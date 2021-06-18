import 'package:get/get.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/qr_scanner_result_page.dart';

class QrScannerController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();
  Rx<PayloadChallengeResult?> resultRx = Rx(null);
  Rx<bool> isRequested = Rx(false);

  void back() {
    Get.back();
  }

  void backToMain() {
    _satorioRepository.updateWallet();
    Get.until((route) => Get.currentRoute == '/() => MainPage');
  }

  void toQrScannerResult() {
    Get.to(() => QrScannerResultPage(), binding: QrScannerBinding());
  }

  void claimRewards() {
    //TODO: remove when get data from QR
    Get.bottomSheet(
      ClaimRewardsBottomSheet(ClaimReward("100", "https://www.google.com/")),
    );


    // Future.value(true)
    //     .then(
    //       (value) {
    //     isRequested.value = true;
    //     return value;
    //   },
    // )
    //     .then((value) => _satorioRepository.claimReward())
    //     .then(
    //       (ClaimReward claimReward) {
    //     isRequested.value = false;
    //     Get.bottomSheet(
    //       ClaimRewardsBottomSheet(claimReward),
    //     );
    //   },
    // )
    //     .catchError(
    //       (value) {
    //     isRequested.value = false;
    //   },
    // );
  }
}

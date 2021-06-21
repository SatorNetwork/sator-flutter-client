import 'package:get/get.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/payload/payload_challenge_result.dart';
import 'package:satorio/domain/entities/qr_result.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/qr_scanner_result_page.dart';

class QrScannerController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();
  Rx<PayloadChallengeResult?> resultRx = Rx(null);
  Rx<bool> isRequested = Rx(false);
  Rx<Show?> showRx = Rx(Show("", "", "", false));

  QrResult? qrResult;

  void back() {
    Get.back();
  }

  void backToMain() {
    _satorioRepository.updateWallet();
    Get.until((route) => Get.currentRoute == '/() => MainPage');
  }

  void toQrScannerResult(String qrId) {
    Get.to(() => QrScannerResultPage(qrId), binding: QrScannerBinding());
  }

  void _loadShow(String showId) {
    _satorioRepository
        .loadShow(showId)
        .then((show) {
          showRx.value = show;
    });
  }

  void getShowEpisodeByQR(String qrCodeId) {
    _satorioRepository
        .getShowEpisodeByQR(qrCodeId)
        .then((qrResult) {
          this.qrResult =  qrResult;
          _loadShow(this.qrResult!.showId);

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
          ClaimRewardsBottomSheet(claimReward),
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

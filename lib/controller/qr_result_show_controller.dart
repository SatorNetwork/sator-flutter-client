import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/qr_show.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';

class QrResultShowController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();
  Rx<bool> isRequested = Rx(false);
  Rx<Show?> showRx = Rx(Show("", "", "", false));
  Rx<QrShow?> qrShowRx = Rx(QrShow("", "", "", 0));

  void loadData(Show show, QrShow qrShow) {
    showRx.value = show;
    qrShowRx.value = qrShow;
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

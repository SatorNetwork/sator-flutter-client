import 'package:get/get.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/claim_reward.dart';
import 'package:satorio/domain/entities/qr_show.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/claim_rewards_bottom_sheet.dart';

class QrResultShowController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();
  final RxBool isRequested = false.obs;
  late final Rx<Show> showRx;
  late final Rx<QrShow> qrShowRx;

  QrResultShowController() {
    QrResultShowArgument argument = Get.arguments as QrResultShowArgument;

    showRx = Rx(argument.show);
    qrShowRx = Rx(argument.qrShow);
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
                  if (Get.isRegistered<MainController>()) {
                    if (Get.currentRoute != '/() => MainPage') {
                      MainController mainController = Get.find();
                      mainController.selectedBottomTabIndex.value =
                          MainController.TabWallet;
                    }
                    backToMain();
                  }
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

class QrResultShowArgument {
  final Show show;
  final QrShow qrShow;

  const QrResultShowArgument(this.show, this.qrShow);
}

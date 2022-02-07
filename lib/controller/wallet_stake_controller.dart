import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/entities/wallet_stake.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/lock_rewards_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/dialog_widget/stake_dialog.dart';
import 'package:satorio/util/extension.dart';

class WalletStakeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<WalletDetail> walletDetailRx;
  late final Rx<WalletStake?> walletStakeRx = Rx(null);

  final RxBool tmpState = false.obs;

  WalletStakeController() {
    WalletStakeArgument argument = Get.arguments as WalletStakeArgument;
    walletDetailRx = Rx(argument.walletDetail);

    _updateWalletStake();
  }

  void back() {
    Get.back();
  }

  void _updateWalletStake() {
    _satorioRepository
        .getStake(walletDetailRx.value.id)
        .then((WalletStake walletStake) {
      walletStakeRx.value = walletStake;
    });
  }

  void toLockRewardsBottomSheet() {
    if (walletDetailRx.value.balance.length <= 0) return;
    Get.bottomSheet(
      LockRewardsBottomSheet(
        'txt_available_lock'.tr,
        walletDetailRx.value.balance[0].displayedValue,
        walletStakeRx.value,
        walletDetailRx.value,
        'txt_add'.tr,
        (double value) {
          _stakeAmount(value);
        },
      ),
      isScrollControlled: true,
    );
  }

  void toUnLockRewardsBottomSheet() {
    if (walletDetailRx.value.balance.length <= 0) return;
    Get.bottomSheet(
      LockRewardsBottomSheet(
        'txt_unlock'.tr,
        walletDetailRx.value.balance[0].displayedValue,
        walletStakeRx.value,
        walletDetailRx.value,
        'txt_unlock'.tr,
        (double value) {
          _unstakeAmount(value);
        },
      ),
      isScrollControlled: true,
    );
  }

  void _stakeAmount(double amount) {
    _satorioRepository
        .stake(
      walletDetailRx.value.id,
      amount,
    )
        .then(
      (bool result) {
        if (result) {
          _updateWalletStake();
          tmpState.value = true;
        }

        Get.dialog(
          DefaultDialog(
            result ? 'txt_success'.tr : 'txt_oops'.tr,
            result
                ? 'txt_stake_success'.tr.format(
                    [
                      amount.toString(),
                      walletDetailRx.value.balance[0].currency
                    ],
                  )
                : 'txt_something_wrong'.tr,
            result ? 'txt_cool'.tr : 'txt_ok'.tr,
            onButtonPressed: () => result ? _updateWalletStake() : () {},
          ),
        );
      },
    );
  }

  void _unstakeAmount(double amount) {
    _satorioRepository.unstake(walletDetailRx.value.id, amount).then(
      (bool result) {
        if (result) {
          _updateWalletStake();
          tmpState.value = false;
        }

        Get.dialog(
          DefaultDialog(
            result ? 'txt_success'.tr : 'txt_oops'.tr,
            result
                ? 'txt_unstake_success'.tr.format(
                    [
                      amount.toStringAsFixed(2),
                      walletDetailRx.value.balance[0].currency
                    ],
                  )
                : 'txt_something_wrong'.tr,
            result ? 'txt_cool'.tr : 'txt_ok'.tr,
          ),
        );
      },
    );
  }
}

class WalletStakeArgument {
  final WalletDetail walletDetail;

  const WalletStakeArgument(this.walletDetail);
}

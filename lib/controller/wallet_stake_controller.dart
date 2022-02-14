import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/lock_rewards_bottom_sheet.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/util/extension.dart';

class WalletStakeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<WalletDetail> walletDetailRx;
  final Rx<WalletStaking?> walletStakingRx = Rx(null);
  final RxDouble possibleMultiplierRx = 0.0.obs;

  final RxBool tmpState = false.obs;
  final RxBool pmState = false.obs;

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
        .then((WalletStaking walletStaking) {
      walletStakingRx.value = walletStaking;
      tmpState.value = walletStakingRx.value!.lockedByYou > 0;
      pmState.value = walletStakingRx.value!.currentMultiplier > 0;
    });
  }

  void toLockRewardsBottomSheet() {
    if (walletDetailRx.value.balance.length <= 0) return;
    possibleMultiplierRx.value = 0.0;
    Get.bottomSheet(
      LockRewardsBottomSheet(
          'txt_available_lock'.tr,
          walletDetailRx.value.balance[0].displayedValue,
          walletStakingRx.value!,
          walletDetailRx.value,
          'txt_add'.tr, (double value) {
        _stakeAmount(value);
      }, () {}, false, this),
      isScrollControlled: true,
    );
  }

  void toUnLockRewardsBottomSheet() {
    if (walletDetailRx.value.balance.length <= 0) return;
    Get.bottomSheet(
      LockRewardsBottomSheet(
          'txt_unlock'.tr,
          walletDetailRx.value.balance[0].displayedValue,
          walletStakingRx.value!,
          walletDetailRx.value,
          'txt_unlock'.tr,
          (double value) {}, () {
        _unstakeAmount();
      }, true, this),
      isScrollControlled: true,
    );
  }

  void possibleMultiplier(double? amount) {
    _satorioRepository.possibleMultiplier(walletDetailRx.value.id, amount!).then((value) {
      possibleMultiplierRx.value = value;
    });
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
          possibleMultiplier(amount);
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
                      walletDetailRx.value.balance[0].currency,
                      possibleMultiplierRx.value,
                    ],
                  )
                : 'txt_something_wrong'.tr,
            result ? 'txt_cool'.tr : 'txt_ok'.tr,
            onButtonPressed: () => result ? _updateWalletStake() : () {},
            icon: result ? Icons.check_rounded : null,
          ),
        );
      },
    );
  }

  void _unstakeAmount() {
    _satorioRepository.unstake(walletDetailRx.value.id).then(
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
                      walletStakingRx.value?.lockedByYou.toStringAsFixed(2),
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

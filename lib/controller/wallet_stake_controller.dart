import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/stake_level.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/entities/wallet_staking.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/bottom_sheet_widget/lock_rewards_bottom_sheet.dart';
import 'package:satorio/util/extension.dart';
import 'package:satorio/util/getx_extension.dart';

class WalletStakeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<WalletDetail> walletDetailRx;
  final Rx<WalletStaking?> walletStakingRx = Rx(null);
  final Rx<List<StakeLevel>> stakeLevelsRx = Rx([]);
  final RxDouble possibleMultiplierRx = 0.0.obs;

  final RxBool tmpState = false.obs;
  final RxBool pmState = false.obs;
  final RxBool isInProgress = false.obs;

  WalletStakeController() {
    WalletStakeArgument argument = Get.arguments as WalletStakeArgument;
    walletDetailRx = Rx(argument.walletDetail);

    _stakeLevels();

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

  // _stakeLevels get loyalty levels and set current as first
  void _stakeLevels() {
    _satorioRepository.stakeLevels().then((List<StakeLevel> stakeLevels) {
      if (stakeLevels.length == 0) return;

      stakeLevelsRx.value = [];

      stakeLevels.forEach((element) {
        if (!element.isCurrent) {
          stakeLevelsRx.update((val) {
            stakeLevelsRx.value.add(element);
          });
        } else {
          stakeLevelsRx.update((val) {
            stakeLevelsRx.value.insert(0, element);
          });
        }
      });
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
        'txt_add'.tr,
        (double value) {
          _stakeAmount(value);
        },
        () {},
        false,
        this,
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
        walletStakingRx.value!,
        walletDetailRx.value,
        'txt_unlock'.tr,
        (double value) {},
        () {
          _unstakeAmount();
        },
        true,
        this,
      ),
      isScrollControlled: true,
    );
  }

  void possibleMultiplier(double? amount) {
    if (amount == null) {
      possibleMultiplierRx.value = 0.0;
      return;
    }
    _satorioRepository
        .possibleMultiplier(walletDetailRx.value.id, amount)
        .then((value) {
      possibleMultiplierRx.value = value;
    });
  }

  //_stakeAmount add tokens to staking pool
  void _stakeAmount(double amount) {
    Future.value(true)
        .then((value) {
          isInProgress.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.stake(
            walletDetailRx.value.id,
            amount,
          ),
        )
        .then(
          (bool result) {
            HapticFeedback.vibrate();

            if (result) {
              possibleMultiplier(amount);
              _updateWalletStake();
              _stakeLevels();
              tmpState.value = true;
              isInProgress.value = false;
            }
            Get.snackbarMessage(
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
            );
          },
        )
        .catchError((error) {
          isInProgress.value = false;
        });
  }

  void _unstakeAmount() {
    Future.value(true)
        .then((value) {
          isInProgress.value = true;
          return true;
        })
        .then(
          (value) => _satorioRepository.unstake(walletDetailRx.value.id),
        )
        .then(
          (bool result) {
            if (result) {
              HapticFeedback.vibrate();

              _updateWalletStake();
              _stakeLevels();
              tmpState.value = false;
              isInProgress.value = false;
            }

            Get.snackbarMessage(
              result ? 'txt_success'.tr : 'txt_oops'.tr,
              result
                  ? 'txt_unstake_success'.tr.format(
                      [
                        walletStakingRx.value?.lockedByYou.toStringAsFixed(2),
                        walletDetailRx.value.balance[0].currency
                      ],
                    )
                  : 'txt_something_wrong'.tr,
            );
          },
        )
        .catchError((error) {
          isInProgress.value = false;
        });
  }
}

class WalletStakeArgument {
  final WalletDetail walletDetail;

  const WalletStakeArgument(this.walletDetail);
}

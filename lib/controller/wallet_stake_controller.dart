import 'package:get/get.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/domain/entities/wallet_stake.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/dialog_widget/stake_dialog.dart';
import 'package:satorio/util/extension.dart';

class WalletStakeController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<WalletDetail> walletDetailRx;
  final Rx<WalletStake?> walletStakeRx = Rx(null);

  final RxBool tmpState = false.obs;

  WalletStakeController() {
    WalletStakeArgument argument = Get.arguments as WalletStakeArgument;
    walletDetailRx = Rx(argument.walletDetail);

    _satorioRepository
        .getStake(walletDetailRx.value.id)
        .then((WalletStake walletStake) {
      walletStakeRx.value = walletStake;
    });
  }

  void back() {
    Get.back();
  }

  void toStakeDialog() {
    if (walletDetailRx.value.balance.length > 0) {
      Get.dialog(
        StakeDialog(
          'txt_available'.tr,
          walletDetailRx.value.balance[0].displayedValue,
          'txt_add'.tr,
          (double value) {
            _stakeAmount(value);
          },
        ),
      );
    }
  }

  void toUnStakeDialog() {
    if ((walletStakeRx.value?.walletStaking?.staked ?? 0.0) > 0 &&
        walletDetailRx.value.balance.length > 0) {
      Get.dialog(
        StakeDialog(
          'txt_staked'.tr,
          '${walletStakeRx.value!.walletStaking!.staked} ${walletDetailRx.value.balance[0].currency}',
          'txt_substract'.tr,
          (double value) {
            _unstakeAmount(value);
          },
        ),
      );
    }
  }

  void _stakeAmount(double amount) {
    _satorioRepository
        .stake(walletDetailRx.value.id, amount)
        .then((bool result) {
      if (result) {
        tmpState.value = true;
        Get.dialog(
          DefaultDialog(
            'txt_success'.tr,
            'txt_stake_success'.tr.format([
              amount.toStringAsFixed(2),
              walletDetailRx.value.balance[0].currency
            ]),
            'txt_cool'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        );
      } else {
        Get.dialog(
          DefaultDialog(
            'txt_oops'.tr,
            'txt_something_wrong'.tr,
            'txt_ok'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        );
      }
    });
  }

  void _unstakeAmount(double amount) {
    _satorioRepository
        .unstake(walletDetailRx.value.id, amount)
        .then((bool result) {
      if (result) {
        tmpState.value = false;
        Get.dialog(
          DefaultDialog(
            'txt_success'.tr,
            'txt_unstake_success'.tr.format([
              amount.toStringAsFixed(2),
              walletDetailRx.value.balance[0].currency
            ]),
            'txt_cool'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        );
      } else {
        Get.dialog(
          DefaultDialog(
            'txt_oops'.tr,
            'txt_something_wrong'.tr,
            'txt_ok'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        );
      }
    });
  }
}

class WalletStakeArgument {
  final WalletDetail walletDetail;

  const WalletStakeArgument(this.walletDetail);
}

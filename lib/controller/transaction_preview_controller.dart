import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class TransactionPreviewController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Transfer> transferRx;
  final RxBool isSendRequestInProgress = false.obs;

  TransactionPreviewController() {
    TransactionPreviewArgument argument =
        Get.arguments as TransactionPreviewArgument;
    transferRx = Rx(argument.transfer);
  }

  void back() {
    Get.back();
  }

  void send() {
    Future.value(true)
        .then((value) {
          isSendRequestInProgress.value = true;
          return value;
        })
        .then(
          (value) => _satorioRepository.confirmTransfer(
              transferRx.value.senderWalletId, transferRx.value.txHash),
        )
        .then(
          (bool result) {
            isSendRequestInProgress.value = false;
            HapticFeedback.vibrate();

            Get.dialog(
              DefaultDialog(
                result ? 'txt_success'.tr : 'txt_oops'.tr,
                result
                    ? 'txt_transaction_sent'.tr
                    : 'txt_transaction_not_sent'.tr,
                result ? 'txt_cool'.tr : 'txt_ok'.tr,
                icon: result ? Icons.check_rounded : null,
                onButtonPressed: result
                    ? () {
                        backToMain();
                      }
                    : null,
              ),
            );
          },
        )
        .catchError(
          (value) {
            isSendRequestInProgress.value = false;
          },
        );
  }
}

class TransactionPreviewArgument {
  final Transfer transfer;

  const TransactionPreviewArgument(this.transfer);
}

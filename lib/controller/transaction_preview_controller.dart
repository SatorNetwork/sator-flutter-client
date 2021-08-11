import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/domain/entities/transfer.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

class TransactionPreviewController extends GetxController with BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Transfer> transferRx;

  TransactionPreviewController() {
    TransactionPreviewArgument argument =
        Get.arguments as TransactionPreviewArgument;
    transferRx = Rx(argument.transfer);
  }

  void back() {
    Get.back();
  }

  void send() {
    _satorioRepository
        .confirmTransfer(
            transferRx.value.senderWalletId, transferRx.value.txHash)
        .then(
      (bool result) {
        if (result) {
          Get.dialog(
            DefaultDialog(
              'txt_success'.tr,
              'txt_transaction_sent'.tr,
              'txt_cool'.tr,
              icon: Icons.check_rounded,
              onPressed: () {
                backToMain();
              },
            ),
          );
        } else {
          Get.dialog(
            DefaultDialog(
              'txt_oops'.tr,
              'txt_transaction_not_sent'.tr,
              'txt_ok'.tr,
              onPressed: () {
                Get.back();
              },
            ),
          );
        }
      },
    );
  }
}

class TransactionPreviewArgument {
  final Transfer transfer;

  const TransactionPreviewArgument(this.transfer);
}

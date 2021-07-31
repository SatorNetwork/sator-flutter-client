import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/binding/transaction_preview_binding.dart';
import 'package:satorio/controller/qr_scanner_controller.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/bottom_sheet_widget/transacting_tips_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';
import 'package:satorio/ui/page_widget/transaction_preview_page.dart';

class WalletSendController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  late final TextEditingController toAddressController;
  final TextEditingController noteController = TextEditingController();

  late final Rx<WalletDetail?> fromWalletDetailRx;

  late final RxBool toAddressVisibility;

  WalletSendController() {
    WalletSendArgument argument = Get.arguments as WalletSendArgument;
    toAddressController = TextEditingController(text: argument.toAddress);
    fromWalletDetailRx = Rx(argument.fromWalletDetail);

    toAddressVisibility =
        (argument.toAddress != null && argument.toAddress!.isNotEmpty).obs;
  }

  void back() {
    Get.back();
  }

  void showTransactingTips() {
    Get.bottomSheet(
      TransactingTipsBottomSheet(),
    );
  }

  void toPreview() {
    Get.to(
      () => TransactionPreviewPage(),
      binding: TransactionPreviewBinding(),
    );
  }

  void selectFromOwnWallets() {
    // TODO
  }

  void selectFromContacts() {
    // TODO
  }

  void enterAddress() {
    toAddressVisibility.value = true;
  }

  void scanQr() async {
    String? result = await Get.to(
      () => QrScannerPage(),
      binding: QrScannerBinding(),
      arguments: QrScannerArgument(true),
    );

    if (result != null && result.isNotEmpty) {
      toAddressController.value = TextEditingValue(
        text: result,
        selection: TextSelection.fromPosition(
          TextPosition(offset: result.length),
        ),
      );

      toAddressVisibility.value = true;
    }
  }
}

class WalletSendArgument {
  final WalletDetail? fromWalletDetail;
  final String? toAddress;

  const WalletSendArgument(this.fromWalletDetail, this.toAddress);
}

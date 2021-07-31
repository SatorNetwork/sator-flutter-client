import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/transaction_preview_binding.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/bottom_sheet_widget/transacting_tips_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/transaction_preview_page.dart';

class WalletSendController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  late final TextEditingController toAddressController;
  final TextEditingController noteController = TextEditingController();

  late final Rx<WalletDetail?> fromWalletDetailRx;

  final RxBool toAddressVisibility = false.obs;

  WalletSendController() {
    WalletSendArgument argument = Get.arguments as WalletSendArgument;
    toAddressController = TextEditingController(text: argument.toAddress);
    fromWalletDetailRx = Rx(argument.fromWalletDetail);
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

  void scanQr() {
    // TODO
  }
}

class WalletSendArgument {
  final WalletDetail? fromWalletDetail;
  final String? toAddress;

  const WalletSendArgument(this.fromWalletDetail, this.toAddress);
}

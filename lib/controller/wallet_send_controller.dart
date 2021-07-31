import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/transaction_preview_binding.dart';
import 'package:satorio/domain/entities/wallet_detail.dart';
import 'package:satorio/ui/bottom_sheet_widget/transacting_tips_bottom_sheet.dart';
import 'package:satorio/ui/page_widget/transaction_preview_page.dart';

class WalletSendController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final Rx<WalletDetail?> fromWalletDetailRx = Rx(null);
  final Rx<String?> toAddressRx = Rx(null);

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
}

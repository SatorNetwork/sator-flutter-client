import 'package:get/get.dart';
import 'package:satorio/binding/wallet_stacked_binding.dart';
import 'package:satorio/ui/page_widget/wallet_stacked_page.dart';

class TransactionPreviewController extends GetxController {
  void back() {
    Get.back();
  }

  void send() {
    Get.to(() => WalletStackedPage(), binding: WalletStackedBinding());
  }
}

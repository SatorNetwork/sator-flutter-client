import 'package:get/get.dart';
import 'package:satorio/controller/transaction_preview_controller.dart';

class TransactionPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionPreviewController>(
      () => TransactionPreviewController(),
    );
  }
}

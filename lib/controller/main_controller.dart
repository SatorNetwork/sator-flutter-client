import 'package:get/get.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';

class MainController extends GetxController {
  final RxInt selectedBottomTabIndex = 0.obs;

  void toQrScanner() {
    Get.to(() => QrScannerPage(), binding: QrScannerBinding());
  }
}

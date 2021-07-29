import 'package:get/get.dart';
import 'package:satorio/controller/qr_result_show_controller.dart';

class QrResultShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrResultShowController>(() => QrResultShowController());
  }
}

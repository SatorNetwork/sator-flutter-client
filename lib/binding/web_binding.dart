import 'package:get/get.dart';
import 'package:satorio/controller/web_controller.dart';

class WebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebController>(() => WebController());
  }
}

import 'package:get/get.dart';
import 'package:satorio/controller/active_realms_controller.dart';

class ActiveRealmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveRealmsController>(() => ActiveRealmsController());
  }
}

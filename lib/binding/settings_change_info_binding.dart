import 'package:get/get.dart';
import 'package:satorio/controller/settings_change_info_controller.dart';

class SettingsChangeInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsChangeInfoController>(() => SettingsChangeInfoController());
  }
}

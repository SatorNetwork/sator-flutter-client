import 'package:get/get.dart';
import 'package:satorio/controller/settings_about_controller.dart';

class SettingsAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsAboutController>(() => SettingsAboutController());
  }
}

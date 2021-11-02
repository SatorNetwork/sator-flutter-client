import 'package:get/get.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/ui/page_widget/web_page.dart';

class SettingsAboutController extends GetxController {

  void toWebPage(String url) {
    Get.to(
          () => WebPage(),
      binding: WebBinding(),
      arguments: WebArgument(
        url,
      ),
    );
  }

  void back() {
    Get.back();
  }
}

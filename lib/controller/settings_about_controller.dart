import 'package:get/get.dart';
import 'package:satorio/binding/web_binding.dart';
import 'package:satorio/controller/web_controller.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/ui/page_widget/web_page.dart';

class SettingsAboutController extends GetxController
    with NonWorkingFeatureMixin {

  void toNonWorkingDialog() {
    toNonWorkingFeatureDialog();
  }

  void toTermsOfUse() {
    Get.to(
      () => WebPage(),
      binding: WebBinding(),
      arguments: WebArgument(
        'https://backoffice.sator.io/legal/terms-of-use',
      ),
    );
  }

  void back() {
    Get.back();
  }
}

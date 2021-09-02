import 'package:get/get.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';

mixin NonWorkingFeatureMixin {
  toNonWorkingFeatureDialog() {
    Get.dialog(
      DefaultDialog(
        'txt_oops'.tr,
        'txt_non_working_feature'.tr,
        'txt_ok'.tr,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

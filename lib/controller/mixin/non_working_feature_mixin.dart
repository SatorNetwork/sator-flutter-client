import 'package:get/get.dart';
import 'package:satorio/util/getx_extension.dart';

mixin NonWorkingFeatureMixin {
  toNonWorkingFeatureDialog() {
    Get.snackbarMessage(
      'txt_coming_soon'.tr,
      'txt_non_working_feature'.tr,
    );
  }
}

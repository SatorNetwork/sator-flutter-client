import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';

mixin NonWorkingFeatureMixin {
  toNonWorkingFeatureDialog() {
    Get.snackbar(
      'txt_coming_soon'.tr,
      'txt_non_working_feature'.tr,
      backgroundColor: SatorioColor.carnation_pink.withOpacity(0.8),
      colorText: SatorioColor.darkAccent,
      duration: Duration(seconds: 4),
    );
  }
}

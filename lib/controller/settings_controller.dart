import 'package:get/get.dart';
import 'package:satorio/binding/select_avatar_binding.dart';
import 'package:satorio/controller/mixin/back_to_main_mixin.dart';
import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/ui/page_widget/select_avatar_page.dart';

class SettingsController extends GetxController with NonWorkingFeatureMixin, BackToMainMixin {
  final SatorioRepository _satorioRepository = Get.find();

  void toNonWorkingDialog() {
    toNonWorkingFeatureDialog();
  }

  void toSelectAvatar() {
    Get.to(() => SelectAvatarPage(),
        binding: SelectAvatarBinding(),
        arguments: SelectAvatarArgument(SelectAvatarType.settings));
  }

  void back() {
    Get.back();
  }
}
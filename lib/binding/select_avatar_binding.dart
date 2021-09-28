import 'package:get/get.dart';
import 'package:satorio/controller/personal_profile_controller.dart';
import 'package:satorio/controller/profile_controller.dart';
import 'package:satorio/controller/select_avatar_controller.dart';

class SelectAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectAvatarController>(() => SelectAvatarController());

    Get.lazyPut<PersonalProfileController>(() => PersonalProfileController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

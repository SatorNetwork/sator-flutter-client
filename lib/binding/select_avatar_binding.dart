import 'package:get/get.dart';

import 'package:satorio/controller/select_avatar_controller.dart';

class SelectAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectAvatarController>(() => SelectAvatarController());
  }
}

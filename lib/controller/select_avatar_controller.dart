import 'package:get/get.dart';

import 'package:satorio/domain/repositories/sator_repository.dart';

import '../util/avatar_list.dart';
import '../util/avatar_list.dart';

class SelectAvatarController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<String?> avatarRx = Rx(avatars[0]);

  String? userName;

  SelectAvatarController() {
    SelectAvatarArguments argument = Get.arguments as SelectAvatarArguments;

    userName = argument.userName;
  }

  void setAvatar(int index) {
    avatarRx.value = avatars[index];
  }
}

class SelectAvatarArguments {
  final String userName;

  SelectAvatarArguments(this.userName);
}

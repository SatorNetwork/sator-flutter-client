import 'package:get/get.dart';

import 'package:satorio/domain/repositories/sator_repository.dart';

class SelectAvatarController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  String? userName;

  SelectAvatarController() {
    SelectAvatarArguments argument = Get.arguments as SelectAvatarArguments;

    userName = argument.userName;
  }
}

class SelectAvatarArguments {
  final String userName;

  SelectAvatarArguments(this.userName);
}

import 'package:get/get.dart';

class NftItemDetailController extends GetxController {
  NftItemDetailController() {
    NftItemDetailArgument argument = Get.arguments as NftItemDetailArgument;
  }

  void back() {
    Get.back();
  }

  void buy() {}

  void addToFavourite() {}
}

class NftItemDetailArgument {}

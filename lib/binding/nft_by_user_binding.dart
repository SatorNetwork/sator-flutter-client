import 'package:get/get.dart';
import 'package:satorio/controller/nft_by_user_controller.dart';

class NftByUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NftByUserController>(() => NftByUserController());
  }
}

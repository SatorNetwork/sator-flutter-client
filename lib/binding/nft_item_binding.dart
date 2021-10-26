import 'package:get/get.dart';
import 'package:satorio/controller/nft_item_controller.dart';

class NftItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NftItemController>(() => NftItemController());
  }
}

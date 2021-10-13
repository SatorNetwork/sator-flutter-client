import 'package:get/get.dart';
import 'package:satorio/controller/nft_item_detail_controller.dart';

class NftItemDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NftItemDetailController>(() => NftItemDetailController());
  }
}

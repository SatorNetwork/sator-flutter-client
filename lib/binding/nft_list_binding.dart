import 'package:get/get.dart';
import 'package:satorio/controller/nft_list_controller.dart';

class NftListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NftListController>(() => NftListController());
  }
}

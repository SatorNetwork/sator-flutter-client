import 'package:get/get.dart';
import 'package:satorio/controller/nfts_controller.dart';

class NFTsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NFTsController>(() => NFTsController());
  }
}

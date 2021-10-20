import 'package:get/get.dart';
import 'package:satorio/controller/nft_categories_controller.dart';

class NftCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NftCategoriesController>(() => NftCategoriesController());
  }
}

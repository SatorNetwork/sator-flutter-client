import 'package:get/get.dart';
import 'package:satorio/controller/show_detail_controller.dart';

class ShowDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowDetailController>(() => ShowDetailController());
  }
}

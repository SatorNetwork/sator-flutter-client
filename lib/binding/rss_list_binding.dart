import 'package:get/get.dart';
import 'package:satorio/controller/rss_list_controller.dart';

class RssListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RssListController>(() => RssListController());
  }
}

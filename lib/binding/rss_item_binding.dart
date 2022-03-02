import 'package:get/get.dart';
import 'package:satorio/controller/rss_item_controller.dart';

class RssItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RssItemController>(() => RssItemController());
  }
}

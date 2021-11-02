import 'package:get/get.dart';
import 'package:satorio/controller/video_network_controller.dart';

class VideoNetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoNetworkController>(() => VideoNetworkController());
  }
}

import 'package:get/get.dart';
import 'package:satorio/controller/video_youtube_controller.dart';

class VideoYoutubeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoYoutubeController>(() => VideoYoutubeController());
  }
}

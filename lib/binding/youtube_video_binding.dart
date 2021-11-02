import 'package:get/get.dart';
import 'package:satorio/controller/youtube_video_controller.dart';

class YoutubeVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeVideoController>(() => YoutubeVideoController());
  }
}

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoYoutubeController extends GetxController {
  late final YoutubePlayerController youtubeController;

  VideoYoutubeController() {
    VideoYoutubeArgument argument = Get.arguments as VideoYoutubeArgument;

    String videoId = YoutubePlayer.convertUrlToId(argument.youtubeLink) ?? '';

    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        forceHD: true,
      ),
    );
  }

  void back() async {
    if (Get.mediaQuery.orientation == Orientation.landscape) {
      youtubeController.toggleFullScreenMode();
    } else {
      Get.back();
    }
  }

  void videoEnded() {
    if (Get.mediaQuery.orientation == Orientation.landscape) {
      youtubeController.toggleFullScreenMode();
    }
    Get.back();
  }
}

class VideoYoutubeArgument {
  final String youtubeLink;

  const VideoYoutubeArgument(this.youtubeLink);
}

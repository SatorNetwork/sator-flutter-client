import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoController extends GetxController {
  late final YoutubePlayerController youtubeController;

  YoutubeVideoController() {
    YoutubeVideoArgument argument = Get.arguments as YoutubeVideoArgument;

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

// Future<void> updateToPortrait() async {
//   if (Get.mediaQuery.orientation == Orientation.landscape) {
//     await SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
//     );
//   }
//   // await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//   await SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.manual,
//     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
//   );
// }
}

class YoutubeVideoArgument {
  final String youtubeLink;

  const YoutubeVideoArgument(this.youtubeLink);
}

import 'package:better_player/better_player.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class VideoNetworkController extends GetxController {
  late final BetterPlayerController playerController;

  VideoNetworkController() {
    VideoNetworkArgument argument = Get.arguments as VideoNetworkArgument;

    playerController = BetterPlayerController(
      BetterPlayerConfiguration(
        fit: BoxFit.contain,
        autoPlay: true,
        allowedScreenSleep: false,
        autoDetectFullscreenDeviceOrientation: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          progressBarPlayedColor: SatorioColor.brand,
          progressBarHandleColor: SatorioColor.brand,
          progressBarBufferedColor: SatorioColor.brand.withOpacity(0.3),
          showControlsOnInitialize: false,
          loadingColor: SatorioColor.brand,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        argument.videoLink,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          preCacheSize: 10 * 1024 * 1024,
          maxCacheSize: 10 * 1024 * 1024,
          maxCacheFileSize: 10 * 1024 * 1024,
          key: argument.videoLink,
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    playerController.addEventsListener(_eventListener);
  }

  @override
  void onClose() {
    playerController.removeEventsListener(_eventListener);
    super.onClose();
  }

  void back() async {
    if (Get.mediaQuery.orientation == Orientation.landscape) {
      playerController.toggleFullScreen();
    } else {
      Get.back();
    }
  }

  void _eventListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      if (Get.mediaQuery.orientation == Orientation.landscape) {
        playerController.toggleFullScreen();
      }
      Get.back();
    }
  }
}

class VideoNetworkArgument {
  final String videoLink;

  const VideoNetworkArgument(this.videoLink);
}

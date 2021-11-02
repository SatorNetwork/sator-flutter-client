import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/video_youtube_controller.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoYoutubePage extends GetView<VideoYoutubeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.youtubeController,
          onEnded: (metaData) {
            controller.videoEnded();
          },
          showVideoProgressIndicator: true,
          progressIndicatorColor: SatorioColor.brand,
          bufferIndicator: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(
              SatorioColor.brand,
            ),
          ),
          progressColors: ProgressBarColors(
            playedColor: SatorioColor.brand,
            handleColor: SatorioColor.brand,
            bufferedColor: SatorioColor.brand.withOpacity(0.3),
          ),
        ),
        builder: (context, player) => Container(
          child: Center(
            child: player,
          ),
        ),
      ),
    );
  }
}

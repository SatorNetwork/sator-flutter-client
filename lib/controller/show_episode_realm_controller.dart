import 'package:get/get.dart';
import 'package:satorio/binding/show_episode_quiz_binding.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/entities/show_episode.dart';
import 'package:satorio/domain/entities/show_season.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/episode_realm_dialog.dart';
import 'package:satorio/ui/page_widget/show_episode_quiz_page.dart';

class ShowEpisodeRealmController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<ShowDetail?> showDetailRx = Rx(null);
  final Rx<ShowSeason?> showSeasonRx = Rx(null);
  final Rx<ShowEpisode?> showEpisodeRx = Rx(null);
  final Rx<bool> isRealmActivatedRx = Rx(false);

  void updateData(
      ShowDetail showDetail, ShowSeason showSeason, ShowEpisode showEpisode) {
    showDetailRx.value = showDetail;
    showSeasonRx.value = showSeason;
    showEpisodeRx.value = showEpisode;

    _satorioRepository.isChallengeActivated(showEpisode.id).then((bool result) {
      isRealmActivatedRx.value = result;
      print('$result');
    });
  }

  void back() {
    Get.back();
  }

  void toEpisodeRealmDialog() {
    if (showSeasonRx.value != null && showEpisodeRx.value != null) {
      Get.dialog(
        EpisodeRealmDialog(
          onStartQuizPressed: () {
            Get.back();
            Get.to(
              () => ShowEpisodeQuizPage(
                showSeasonRx.value!,
                showEpisodeRx.value!,
              ),
              binding: ShowEpisodeQuizBinding(),
            );
          },
          onScanQrPressed: () {
            Get.back();
            // TODO: open qr scanner
          },
        ),
      );
    }
  }
}

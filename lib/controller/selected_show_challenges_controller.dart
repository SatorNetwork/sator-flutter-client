import 'package:get/get.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class SelectedShowChallengesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<ChallengeSimple>> selectedShowChallengesRx = Rx([]);
  final Rx<String> showTitle = Rx(null);

  void back() {
    Get.back();
  }

  void loadChallenges(Show show) {
    showTitle.value = show.title;
    _satorioRepository
        .selectedShowChallenges(id: show.id)
        .then((List<ChallengeSimple> selectedShowChallenges) {
      selectedShowChallengesRx.update((value) {
        value.addAll(selectedShowChallenges);
      });
    });
  }
}

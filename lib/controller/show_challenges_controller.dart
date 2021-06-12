import 'package:get/get.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';

class ShowChallengesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late Show show;

  final Rx<List<ChallengeSimple>> showChallengesRx = Rx([]);

  void back() {
    Get.back();
  }

  void loadChallenges(Show show) {
    this.show = show;
    _satorioRepository
        .showChallenges(show.id)
        .then((List<ChallengeSimple> showChallenges) {
      showChallengesRx.update((value) {
        if (value != null) value.addAll(showChallenges);
      });
    });
  }

  toChallenge(ChallengeSimple challengeSimple) {
    Get.to(() => ChallengePage(challengeSimple.id),
        binding: ChallengeBinding());
  }
}

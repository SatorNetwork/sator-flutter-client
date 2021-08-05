import 'package:get/get.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';

class ShowChallengesController extends GetxController
    with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  late final Rx<Show> showRx;
  final Rx<List<ChallengeSimple>> showChallengesRx = Rx([]);

  ShowChallengesController() {
    ShowChallengesArgument argument = Get.arguments as ShowChallengesArgument;
    showRx = Rx(argument.show);

    _satorioRepository
        .showChallenges(argument.show.id)
        .then((List<ChallengeSimple> showChallenges) {
      showChallengesRx.update((value) {
        if (value != null) value.addAll(showChallenges);
      });
    });
  }

  void back() {
    Get.back();
  }

  toChallenge(ChallengeSimple challengeSimple) {
    Get.to(
      () => ChallengePage(),
      binding: ChallengeBinding(),
      arguments: ChallengeArgument(challengeSimple.id),
    );
  }
}

class ShowChallengesArgument {
  final Show show;

  const ShowChallengesArgument(this.show);
}

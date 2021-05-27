import 'package:get/get.dart';
import 'package:satorio/data/model/challenge_simple_model.dart';
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
    //TODO: change when data will be available
    // _satorioRepository
    //     .selectedShowChallenges(id: show.id)
    //     .then((List<SelectedShowChallenges> selectedShowChallenges) {
    //   selectedShowChallengesRx.update((value) {
    //     value.addAll(selectedShowChallenges);
    //   });
    // });

    Future.delayed(Duration(milliseconds: 500)).then((value) {
      selectedShowChallengesRx.value = [
        ChallengeSimpleModel(
          'f4f78cac-5db6-4ecc-ad13-5877705f3126',
          'Challenge name',
          'Fast Questions!',
        ),
        ChallengeSimpleModel(
          'f4f78cac-5db6-4ecc-ad13-5877705f3126',
          'Challenge name',
          'Fast Questions!',
        ),
        ChallengeSimpleModel(
          'f4f78cac-5db6-4ecc-ad13-5877705f3126',
          'Challenge name',
          'Fast Questions!',
        ),
        ChallengeSimpleModel(
          'f4f78cac-5db6-4ecc-ad13-5877705f3126',
          'Challenge name',
          'Fast Questions!',
        ),
        ChallengeSimpleModel(
          'f4f78cac-5db6-4ecc-ad13-5877705f3126',
          'Challenge name',
          'Fast Questions!',
        ),
      ];
    });
  }
}

import 'package:get/get.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/domain/entities/challenge_simple.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';

class ChallengesController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  static const int _itemsPerPage = 10;
  static const int _initialPage = 1;

  final RxInt _pageRx = _initialPage.obs;
  final RxBool _isLoadingRx = false.obs;
  final RxBool _isAllLoadedRx = false.obs;

  final Rx<List<ChallengeSimple>> challengesRx = Rx([]);

  ChallengesController();

  @override
  void onInit() {
    super.onInit();
    loadChallenges();
  }

  void back() {
    Get.back();
  }

  void loadChallenges() {
    if (_isAllLoadedRx.value) return;

    if (_isLoadingRx.value) return;

    Future.value(true)
        .then((value) {
          _isLoadingRx.value = true;
          return value;
        })
        .then((value) => _satorioRepository.challenges(
              page: _pageRx.value,
              itemsPerPage: _itemsPerPage,
            ))
        .then((List<ChallengeSimple> challenges) {
          challengesRx.update((value) {
            if (value != null) value.addAll(challenges);
          });

          _isAllLoadedRx.value = challenges.isEmpty;
          _isLoadingRx.value = false;
          _pageRx.value = _pageRx.value + 1;
        })
        .catchError(
          (value) {
            _isLoadingRx.value = false;
          },
        );
  }

  void toChallenge(ChallengeSimple challenge) {
    Get.to(
      () => ChallengePage(),
      binding: ChallengeBinding(),
      arguments: ChallengeArgument(challenge.id),
    );
  }
}

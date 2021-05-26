import 'package:get/get.dart';
import 'package:satorio/domain/entities/selected_show_challenges.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class SelectedShowChallengesController extends GetxController with SingleGetTickerProviderMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<SelectedShowChallenges>> selectedShowChallengesRx = Rx([]);

  @override
  void onInit() {
    _loadSelectedShowChallenges();
  }

  void _loadSelectedShowChallenges() {
    _satorioRepository.selectedShowChallenges().then((List<SelectedShowChallenges> selectedShowChallenges) {
      print('${selectedShowChallenges.length}');
      selectedShowChallengesRx.value = selectedShowChallenges;
    });
  }
}

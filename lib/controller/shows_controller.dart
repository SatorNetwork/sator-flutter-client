import 'package:get/get.dart';
import 'package:satorio/binding/challenge_detail_binding.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/challenge_detail_page.dart';

class ShowsController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> showsRx = Rx([]);

  @override
  void onInit() {
    loadShows();
  }

  void loadShows() {
    _satorioRepository.shows().then((List<Show> shows) {
      showsRx.update((value) {
        value.addAll(shows);
      });
    });
  }

  void toShowChallenges(Show show) {
    // TODO : move to show's challenge
    Get.to(() => ChallengeDetailPage(''), binding: ChallengeDetailBinding());
  }
}

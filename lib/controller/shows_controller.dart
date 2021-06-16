import 'package:get/get.dart';
import 'package:satorio/binding/show_challenges_binding.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_challenges_page.dart';

class ShowsController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> showsRx = Rx([]);

  @override
  void onInit() {
    super.onInit();
    loadShows();
  }

  void loadShows() {
    _satorioRepository.shows().then((List<Show> shows) {
      showsRx.update((value) {
        if (value != null) value.addAll(shows);
      });
    });
  }

  void toShowChallenges(Show show) {
    Get.to(() => ShowChallengesPage(show), binding: ShowChallengesBinding());
  }
}

import 'package:get/get.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ShowsController extends GetxController {

  final SatorioRepository _satorioRepository = Get.find();

  final Rx<List<Show>> showsRx = Rx([]);

  void loadShows() {
    _satorioRepository.shows().then((List<Show> shows) {
      print('${shows.length}');
      showsRx.update((value) {
        value.addAll(shows);
      });
    });
  }

}
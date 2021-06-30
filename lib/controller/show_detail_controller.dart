import 'package:get/get.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class ShowDetailController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();
  final Rx<ShowDetail?> showDetailRx = Rx(null);

  back() {
    Get.back();
  }

  void loadShowDetail(Show show) {
    _satorioRepository.showDetail(show.id).then((showDetail) {
      showDetailRx.value = showDetail;
    });
  }

  void toEpisodes() {}
}

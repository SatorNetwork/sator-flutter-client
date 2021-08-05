import 'package:get/get.dart';
import 'package:satorio/binding/show_episodes_binding.dart';
import 'package:satorio/controller/show_episodes_controller.dart';
import 'package:satorio/domain/entities/show.dart';
import 'package:satorio/domain/entities/show_detail.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/show_episodes_page.dart';

class ShowDetailController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();
  final Rx<ShowDetail?> showDetailRx = Rx(null);

  ShowDetailController() {
    ShowDetailArgument argument = Get.arguments as ShowDetailArgument;

    _satorioRepository.showDetail(argument.show.id).then((showDetail) {
      showDetailRx.value = showDetail;
    });
  }

  void back() {
    Get.back();
  }

  void toEpisodes() {
    if (showDetailRx.value != null) {
      Get.to(
        () => ShowEpisodesPage(),
        binding: ShowEpisodesBinding(),
        arguments: ShowEpisodesArgument(showDetailRx.value!),
      );
    }
  }
}

class ShowDetailArgument {
  final Show show;

  const ShowDetailArgument(this.show);
}

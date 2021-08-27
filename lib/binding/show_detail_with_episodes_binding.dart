import 'package:get/get.dart';
import 'package:satorio/controller/show_detail_with_episodes_controller.dart';

class ShowDetailWithEpisodesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowDetailWithEpisodesController>(
      () => ShowDetailWithEpisodesController(),
    );
  }
}

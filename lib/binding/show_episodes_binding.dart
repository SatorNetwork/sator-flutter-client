import 'package:get/get.dart';
import 'package:satorio/controller/show_episodes_controller.dart';

class ShowEpisodesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowEpisodesController>(() => ShowEpisodesController());
  }
}

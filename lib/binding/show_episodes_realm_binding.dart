import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_realm_controller.dart';

class ShowEpisodesRealmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowEpisodeRealmController>(() => ShowEpisodeRealmController());
  }
}

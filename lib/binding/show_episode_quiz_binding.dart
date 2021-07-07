import 'package:get/get.dart';
import 'package:satorio/controller/show_episode_quiz_controller.dart';

class ShowEpisodeQuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowEpisodeQuizController>(() => ShowEpisodeQuizController());
  }
}

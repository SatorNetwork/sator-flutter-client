import 'package:get/get.dart';
import 'package:satorio/controller/show_challenges_controller.dart';

class ShowChallengesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowChallengesController>(() => ShowChallengesController());
  }
}

import 'package:get/get.dart';
import 'package:satorio/controller/selected_show_challenges_controller.dart';

class SelectedShowChallengesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedShowChallengesController>(() => SelectedShowChallengesController());
  }
}

import 'package:get/get.dart';
import 'package:satorio/controller/challenges_controller.dart';

class ChallengesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengesController>(() => ChallengesController());
  }
}

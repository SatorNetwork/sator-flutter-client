import 'package:get/get.dart';
import 'package:satorio/controller/challenge_detail_controller.dart';

class ChallengeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChallengeDetailController>(() => ChallengeDetailController());
  }
}

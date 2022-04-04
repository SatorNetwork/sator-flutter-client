import 'package:get/get.dart';
import 'package:satorio/controller/puzzle_controller.dart';

class PuzzleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PuzzleController>(() => PuzzleController());
  }
}

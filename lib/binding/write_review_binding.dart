import 'package:get/get.dart';
import 'package:satorio/controller/write_review_controller.dart';

class WriteReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WriteReviewController>(() => WriteReviewController());
  }
}

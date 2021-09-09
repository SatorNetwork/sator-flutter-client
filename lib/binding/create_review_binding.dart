import 'package:get/get.dart';
import 'package:satorio/controller/create_review_controller.dart';

class CreateReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateReviewController>(() => CreateReviewController());
  }
}

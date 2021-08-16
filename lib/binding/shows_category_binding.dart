import 'package:get/get.dart';
import 'package:satorio/controller/shows_category_controller.dart';

class ShowsCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowsCategoryController>(() => ShowsCategoryController());
  }
}

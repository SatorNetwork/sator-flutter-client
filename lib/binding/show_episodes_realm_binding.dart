import 'package:get/get.dart';
import 'package:satorio/controller/realm_controller.dart';

class ShowEpisodesRealmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealmController>(() => RealmController());
  }
}

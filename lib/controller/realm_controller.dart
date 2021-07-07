import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class RealmController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  void back() {
    Get.back();
  }

}

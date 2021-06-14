import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class MainController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final RxInt selectedBottomTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWallet();
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWallet() {
    _satorioRepository.updateWallet();
  }
}

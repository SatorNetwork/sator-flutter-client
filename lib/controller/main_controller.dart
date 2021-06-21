import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';

class MainController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final RxInt selectedBottomTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWalletBalance();
    _loadWallets();
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWalletBalance() {
    _satorioRepository.updateWalletBalance();
  }

  void _loadWallets() {
    _satorioRepository.updateWallets();
  }
}

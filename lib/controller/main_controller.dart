import 'package:get/get.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';

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

  void backToMain() {
    _satorioRepository.updateWalletBalance();
    Get.until((route) => Get.currentRoute == '/() => MainPage');
  }

  void _loadWallets() {
    _satorioRepository.updateWallets();
  }

  void toQrScanner() {
    Get.to(() => QrScannerPage(), binding: QrScannerBinding());
  }
}

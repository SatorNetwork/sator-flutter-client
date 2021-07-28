import 'package:get/get.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';

class MainController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  static const int TabHome = 0;
  static const int TabNfts = 2;
  static const int TabWallet = 3;
  static const int TabProfile = 4;

  final RxInt selectedBottomTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWalletBalance();
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWalletBalance() {
    _satorioRepository.updateWalletBalance();
  }

  void toQrScanner() {
    Get.to(() => QrScannerPage(), binding: QrScannerBinding());
  }
}

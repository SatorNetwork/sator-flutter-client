import 'package:get/get.dart';
import 'package:satorio/binding/show_episodes_realm_binding.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';
import 'package:satorio/ui/page_widget/show_episodes_realm_page.dart';

class MainController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  final RxInt selectedBottomTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWalletBalance();
    loadWallets();
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWalletBalance() {
    _satorioRepository.updateWalletBalance();
  }

  void loadWallets() {
    _satorioRepository.updateWallets();
  }

  void toQrScanner() {
    Get.to(() => QrScannerPage(), binding: QrScannerBinding());
  }

  void toRealmTest() {
    Get.to(() => ShowEpisodesRealmPage(), binding: ShowEpisodesRealmBinding());
  }
}

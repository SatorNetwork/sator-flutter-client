import 'package:get/get.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/controller/qr_scanner_controller.dart';
import 'package:satorio/domain/entities/nft_home.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';

class MainController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  static const int TabHome = 0;
  static const int TabScan = 1;
  static const int TabNfts = 2;
  static const int TabWallet = 3;
  static const int TabProfile = 4;

  final RxInt selectedBottomTabIndex = 0.obs;

  final Rx<NftHome?> nftHomeRx = Rx(null);

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
    _loadWalletBalance();
    loadNftHome();
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWalletBalance() {
    _satorioRepository.updateWalletBalance();
  }

  void loadNftHome() {
    _satorioRepository.nftHome().then(
      (NftHome nftHome) {
        nftHomeRx.value = nftHome;
      },
    );
  }

  void toQrScanner() {
    Get.to(
      () => QrScannerPage(),
      binding: QrScannerBinding(),
      arguments: QrScannerArgument(false),
    );
  }
}

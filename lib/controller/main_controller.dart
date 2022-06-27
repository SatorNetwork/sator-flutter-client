import 'package:get/get.dart';
import 'package:satorio/binding/challenge_binding.dart';
import 'package:satorio/binding/qr_scanner_binding.dart';
import 'package:satorio/controller/challenge_controller.dart';
import 'package:satorio/controller/qr_scanner_controller.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/challenge_page.dart';
import 'package:satorio/ui/page_widget/qr_scanner_page.dart';
import 'package:satorio/unity/unity_view_page.dart';

class MainController extends GetxController {
  final SatorioRepository _satorioRepository = Get.find();

  static const int TabHome = 0;
  static const int TabScan = 1;
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

  @override
  void onReady() {
    _tryHandleDeepLink();
  }

  void _tryHandleDeepLink() {
    if (Get.arguments != null && Get.arguments is MainArgument) {
      final deepLink = (Get.arguments as MainArgument).deepLink;

      if (deepLink != null) {
        final List<String> pathSegments = deepLink.pathSegments;
        switch (pathSegments.length) {
          case 1:
            {
              if (pathSegments[0] == 'quiz-invite') {
                final id = deepLink.queryParameters['id'];
                if (id != null && id.isNotEmpty) {
                  Get.to(
                        () => ChallengePage(),
                    binding: ChallengeBinding(),
                    arguments: ChallengeArgument(id),
                  );
                }
              }
              break;
            }
        }
      }
    }
  }

  void _loadProfile() {
    _satorioRepository.updateProfile();
  }

  void _loadWalletBalance() {
    _satorioRepository.updateWalletBalance();
  }

  void toQrScanner() {
    Get.to(
          () => UnityViewPage(),
    );
  }
}

class MainArgument {
  final Uri? deepLink;

  const MainArgument(this.deepLink);
}

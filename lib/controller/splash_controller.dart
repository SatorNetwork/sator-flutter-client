import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';

class SplashController extends GetxController {
  SatorioRepository _satorioRepository = Get.find();

  Uri? deepLink;

  @override
  void onInit() {
    super.onInit();
    _handleDynamicLinks();
    _checkToken();
  }

  Future _handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    void _handleDeepLink(PendingDynamicLinkData? data) {
      if (data == null) return;
      deepLink = data.link;
      print('_handleDeepLink | deeplink: $deepLink');
    }

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      _handleDeepLink(dynamicLink!);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void dummy() {}

  void _checkToken() {
    Future.delayed(Duration(milliseconds: 1000), () {
      _satorioRepository.isTokenValid().then(
        (bool isTokenValid) {
          if (isTokenValid) {
            _checkIsVerified();
          } else {
            _toLogin();
          }
        },
      ).catchError(
        (value) {
          if (!(value is ApiUnauthorizedException)) _toLogin();
        },
      );
    });
  }

  void _checkIsVerified() {
    _satorioRepository.isVerified().then((isVerified) {
      if (isVerified)
        Get.offAll(() => MainPage(), binding: MainBinding());
      else
        Get.offAll(
          () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
        );
    }).catchError(
      (value) {
        if (!(value is ApiUnauthorizedException)) _toLogin();
      },
    );
  }

  void _toLogin() {
    Get.offAll(
      () => LoginPage(),
      binding: LoginBinding(),
      arguments: LoginArgument(deepLink),
    );
  }
}

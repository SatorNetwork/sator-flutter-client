import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/onboarding_binding.dart';
import 'package:satorio/controller/email_verification_controller.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/controller/onboading_controller.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/ui/page_widget/onboardinga_page.dart';
import 'package:satorio/util/onboarding_list.dart';

class SplashController extends GetxController {
  SatorioRepository _satorioRepository = Get.find();

  Uri? deepLink;

  @override
  void onReady() {
    super.onReady();
    _handleDynamicLinks();
    _checkToken();
  }

  Future _handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    void _handleDeepLink(PendingDynamicLinkData? data) {
      if (data == null) return;
      deepLink = data.link;
    }

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          _handleDeepLink(dynamicLink!);
        },
        onError: (OnLinkErrorException e) async {});
  }

  void dummy() {}

  void _checkToken() {
    Future.delayed(
      Duration(milliseconds: 1000),
      () {
        _satorioRepository.validateToken().then(
          (bool isTokenValid) {
            if (isTokenValid) {
              _checkIsVerified();
            } else {
              _checkIsOnBoarding();
            }
          },
        ).catchError(
          (value) {
            _checkIsOnBoarding();
          },
        );
      },
    );
  }

  void _checkIsVerified() {
    _satorioRepository.isVerified().then((isVerified) {
      if (isVerified) {
        _toLogin();
      } else {
        Get.offAll(
          () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
          arguments: EmailVerificationArgument('txt_your_email'.tr, false),
        );
      }
    }).catchError(
      (value) {
        if (!(value is ApiUnauthorizedException)) _toLogin();
      },
    );
  }

  void _checkIsOnBoarding() {
    _satorioRepository.isOnBoarded().then(
      (isOnBoarded) {
        if (isOnBoarded) {
          _toLogin();
        } else {
          _toOnBoarding();
        }
      },
    );
  }

  void _toLogin() {
    _satorioRepository.clearDBandAccessToken().then(
      (value) {
        Get.offAll(
          () => LoginPage(),
          binding: LoginBinding(),
          arguments: LoginArgument(deepLink),
        );
      },
    );
  }

  void _toOnBoarding() {
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'images/bg/onboarding.svg'),
      null,
    );

    onBoardings.forEach((data) {
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoder, data.assetName),
        null,
      );
    });

    Get.offAll(
      () => OnBoardingPage(),
      binding: OnBoardingBinding(),
      arguments: OnBoardingArgument(deepLink),
    );
  }
}

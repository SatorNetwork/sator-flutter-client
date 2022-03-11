import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/login_binding.dart';
import 'package:satorio/binding/onboarding_binding.dart';
import 'package:satorio/controller/email_verification_controller.dart';
import 'package:satorio/controller/login_controller.dart';
import 'package:satorio/controller/onboading_controller.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/login_page.dart';
import 'package:satorio/ui/page_widget/onboardinga_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/util/links.dart';
import 'package:satorio/util/onboarding_list.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends GetxController {
  SatorioRepository _satorioRepository = Get.find();

  Uri? deepLink;

  late int _installedAppVersion;
  late int _minAppVersion;

  @override
  void onInit() async {
    super.onInit();

    _getInstalledAppVersion();
    _getMinAppVersion();
  }

  @override
  void onReady() {
    super.onReady();
    _handleDynamicLinks();
    _satorioRepository.isInited.listen((value) {
      if (value) _checkToken();
    });
  }

  Future _handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    void _handleDeepLink(PendingDynamicLinkData? data) {
      if (data == null) return;
      deepLink = data.link;
    }

    print('SplashController deepLink: $deepLink');

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          _handleDeepLink(dynamicLink!);
        },
        onError: (OnLinkErrorException e) async {});
  }

  void _getInstalledAppVersion() async {
    await PackageInfo.fromPlatform().then((value) {
      _installedAppVersion = int.parse(value.buildNumber);
    });
  }

  void _getMinAppVersion() async {
    await _satorioRepository.appVersion().then((value) {
      _minAppVersion = value;
    });
  }

  void _checkToken() async {
    Future.delayed(
      Duration(milliseconds: 1000),
      () {
        if (_installedAppVersion >= _minAppVersion) {
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
        } else {
          _toUpdateAppDialog();
        }
      },
    );
  }

  void _toUpdateAppDialog() {
    Get.dialog(
        WillPopScope(
          onWillPop: () async {
            if (_installedAppVersion >= _minAppVersion) {
              Get.back(closeOverlays: true);
              return true;
            } else {
              return false;
            }
          },
          child: DefaultDialog(
            'txt_update_app'.tr,
            'txt_update_app_text'.tr,
            'txt_update'.tr,
            icon: Icons.update,
            isBack: false,
            onButtonPressed: () {
              _updateApp();
            },
          ),
        ),
        barrierDismissible: false);
  }

  void _updateApp() {
    if (isAndroid) {
      _launchURL(linkPlayMarket);
    } else {
      _launchURL(linkTestFlight);
    }
  }

  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _checkIsVerified() {
    _satorioRepository.isVerified().then((isVerified) {
      if (isVerified) {
        _toLogin();
      } else {
        Get.offAll(
          () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
          arguments: EmailVerificationArgument(
            'txt_your_email'.tr,
            false,
            deepLink,
          ),
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

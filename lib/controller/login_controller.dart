import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:satorio/binding/create_account_binding.dart';
import 'package:satorio/binding/email_verification_binding.dart';
import 'package:satorio/binding/main_binding.dart';
import 'package:satorio/binding/password_recovery_binding.dart';
import 'package:satorio/controller/create_account_controller.dart';
import 'package:satorio/controller/email_verification_controller.dart';
import 'package:satorio/controller/main_controller.dart';
import 'package:satorio/controller/mixin/validation_mixin.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/page_widget/create_account_page.dart';
import 'package:satorio/ui/page_widget/email_verification_page.dart';
import 'package:satorio/ui/page_widget/forgot_password_page.dart';
import 'package:satorio/ui/page_widget/main_page.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/util/getx_extension.dart';

class LoginController extends GetxController with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LocalAuthentication _localAuth = LocalAuthentication();

  final RxString emailRx = ''.obs;
  final RxString passwordRx = ''.obs;

  final RxBool passwordObscured = true.obs;
  final RxBool isRequested = false.obs;
  final RxBool isBiometric = false.obs;
  final RxBool isRefreshTokenExist = false.obs;

  final SatorioRepository _satorioRepository = Get.find();

  late final Uri? deepLink;

  LoginController() {
    if (Get.arguments == null) {
      deepLink = null;
    } else {
      LoginArgument argument = Get.arguments as LoginArgument;
      deepLink = argument.deepLink;
    }
    print('LoginController deepLink: $deepLink');
    _getBiometric();
  }

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_emailListener);
    passwordController.addListener(_passwordListener);
  }

  @override
  void onClose() {
    emailController.removeListener(_emailListener);
    passwordController.removeListener(_passwordListener);
    super.onClose();
  }

  void _getBiometric() {
    _satorioRepository.isBiometricEnabled().then((value) {
      isBiometric.value = value;
      if (isBiometric.value) {
        _satorioRepository.isRefreshTokenExist().then((isRefreshToken) {
          isRefreshTokenExist.value = isRefreshToken;
          if (isRefreshToken) {
            _satorioRepository.removeTokenIsBiometricEnabled().then((value) {
              _authWithBiometric();
            });
          }
        });
      }
    });
  }

  Future<void> checkingForBioMetrics() async {
    await _localAuth.canCheckBiometrics.then((canCheckBiometrics) {
      if (canCheckBiometrics) {
        _authWithBiometric();
      } else {
        _showRefreshError();
      }
    });
  }

  void _showRefreshError() {
    Get.snackbarMessage(
      'txt_oops'.tr,
      'txt_login_refresh_error'.tr,
    );
  }

  void _authWithBiometric() {
    Future.value(true).then(
      (value) {
        isRequested.value = true;
        return value;
      },
    ).then((value) {
      _localAuth
          .authenticate(
        localizedReason: "Unlock your device",
        useErrorDialogs: true,
        stickyAuth: true,
      )
          .then((value) {
        if (value) {
          _satorioRepository.signInViaRefreshToken().then((isTokenValid) {
            if (isTokenValid) {
              _checkIsVerified();
            } else {
              _showRefreshError();
              isRequested.value = false;
            }
          }).catchError((value) {
            return _satorioRepository.logout().then((value) {
              _showRefreshError();
              isBiometric.value = false;
              isRequested.value = false;
            });
          });
        } else {
          _showRefreshError();
          isBiometric.value = false;
          isRequested.value = false;
        }
      }).catchError((error) {
        _showRefreshError();
        _satorioRepository.markIsBiometricUserDisabled();
        isBiometric.value = false;
        isRequested.value = false;
      });
    });
  }

  void toCreateAccount() {
    Get.off(
      () => CreateAccountPage(),
      binding: CreateAccountBinding(),
      arguments: CreateAccountArgument(deepLink),
    );
  }

  void toForgotPassword() {
    Get.to(() => ForgotPasswordPage(), binding: PasswordRecoveryBinding());
  }

  void signIn() {
    Future.value(true)
        .then(
          (value) {
            isRequested.value = true;
            return value;
          },
        )
        .then(
          (value) => _satorioRepository.signIn(emailRx.value, passwordRx.value),
        )
        .then(
          (isSuccess) {
            if (isSuccess) {
              _satorioRepository
                  .isBiometricUserDisabled()
                  .then((isBiometricUserDisabled) {
                if (isBiometricUserDisabled == null) {
                  _satorioRepository
                      .isBiometricEnabled()
                      .then((isBiometricEnabled) {
                    if (!isBiometricEnabled) {
                      _toEnableBiometricDialog();
                    } else {
                      _checkIsVerified();
                    }
                  });
                } else {
                  _checkIsVerified();
                }
              });
            } else {
              isRequested.value = false;
            }
          },
        )
        .catchError(
          (value) {
            isRequested.value = false;
            handleValidationException(value);
          },
        );
  }

  Future<void> _toEnableBiometricDialog() async {
    Get.dialog(
      DefaultDialog('txt_login_biometric_title'.tr, 'txt_login_biometric_q'.tr,
          'txt_yes'.tr,
          icon: Icons.fingerprint,
          onButtonPressed: () {
            _satorioRepository.markIsBiometricEnabled(true).then((value) {
              _authWithBiometric();
            });
          },
          secondaryButtonText: 'txt_no'.tr,
          onSecondaryButtonPressed: () {
            _satorioRepository.markIsBiometricUserDisabled();
            _checkIsVerified();
          }),
    ).then((value) {
      _satorioRepository.markIsBiometricUserDisabled();
      isRequested.value = false;
    });
  }

  Future<void> _registerToken() async {
    //TODO: refactor
    var deviceInfo = DeviceInfoPlugin();

    var _deviceOsInfo;

    String _deviceId;

    if (!isAndroid) {
      _deviceOsInfo = await deviceInfo.iosInfo;
      _deviceId = _deviceOsInfo.identifierForVendor;
      _getFcmToken(_deviceId);
    } else if (isAndroid) {
      _deviceOsInfo = await deviceInfo.androidInfo;
      _deviceId = _deviceOsInfo.androidId;
      _getFcmToken(_deviceId);
    }
  }

  void _getFcmToken(String deviceId) async {
    _satorioRepository.fcmToken().then((token) {
      _satorioRepository.registerToken(deviceId, token!).then((value) {
        //TODO: handle it
      });
    });
  }

  void _checkIsVerified() {
    _satorioRepository.isVerified().then((isVerified) {
      if (isVerified) {
        _registerToken();
        Get.offAll(
          () => MainPage(),
          binding: MainBinding(),
          arguments: MainArgument(deepLink),
        );
      } else
        Get.to(
          () => EmailVerificationPage(),
          binding: EmailVerificationBinding(),
          arguments: EmailVerificationArgument(emailRx.value, false, deepLink),
        );
      isRequested.value = false;
    });
  }

  void _emailListener() {
    emailRx.value = emailController.text;
  }

  void _passwordListener() {
    passwordRx.value = passwordController.text;
  }
}

class LoginArgument {
  final Uri? deepLink;

  const LoginArgument(this.deepLink);
}

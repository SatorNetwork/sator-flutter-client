import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ConnectivityService extends GetxService {
  late StreamSubscription _subscription;
  SnackbarController? _snackbarController;

  @override
  void onInit() {
    super.onInit();

    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.none:
            _changeStatusBarColor(SatorioColor.error);
            _snackbarController = Get.snackbar(
              'txt_no_internet_connection'.tr,
              'txt_check_your_connection'.tr,
              icon: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
              ),
              titleText: Text(
                'txt_no_internet_connection'.tr,
                style: textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14 * coefficient,
                ),
              ),
              messageText: Text(
                'txt_check_your_connection'.tr,
                style: textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontSize: 12 * coefficient,
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.only(
                left: 16,
                right: 24,
                top: 10,
                bottom: 10,
              ),
              shouldIconPulse: true,
              mainButton: _toSettingsButton(),
              backgroundColor: SatorioColor.error.withOpacity(0.8),
              colorText: Colors.white,
              duration: null,
              snackbarStatus: (SnackbarStatus? status) {
                if (status == SnackbarStatus.CLOSED) {
                  _snackbarController = null;
                }
              },
            );
            break;
          default:
            _changeStatusBarColor(Colors.black.withOpacity(0.25));
            _snackbarController?.close();
            break;
        }
      },
    );
  }

  @override
  void onClose() {
    _snackbarController?.close();
    _subscription.cancel();
    super.onClose();
  }

  TextButton _toSettingsButton() => TextButton(
        onPressed: () {
          AppSettings.openWirelessSettings(asAnotherTask: true);
        },
        child: Text(
          'txt_to_settings'.tr,
          textAlign: TextAlign.center,
          style: textTheme.bodyText2!.copyWith(
            color: Colors.white,
            fontSize: 12 * coefficient,
          ),
        ),
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            side: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
      );

  void _changeStatusBarColor(final Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: color),
    );
  }
}

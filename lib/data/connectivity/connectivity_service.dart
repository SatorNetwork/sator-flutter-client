import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/util/getx_extension.dart';

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
            _snackbarController = Get.snackbarAlert(
              'txt_no_internet_connection'.tr,
              'txt_check_your_connection'.tr,
              iconData: Icons.warning_amber_rounded,
              shouldIconPulse: true,
              buttonText: 'txt_to_settings'.tr,
              onButtonPressed: () {
                AppSettings.openWirelessSettings(asAnotherTask: true);
              },
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

  void _changeStatusBarColor(final Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: color),
    );
  }
}

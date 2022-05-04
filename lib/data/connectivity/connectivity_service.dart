import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ConnectivityService extends GetxService {
  late StreamSubscription _subscriptionon;
  SnackbarController? _snackbarController;

  @override
  void onInit() {
    super.onInit();

    _subscriptionon = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.none:
          _snackbarController = Get.snackbar(
            'txt_no_internet_connection'.tr, 'txt_check_your_connection'.tr,
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            // margin: const EdgeInsets.symmetric(horizontal: 20),
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
          _snackbarController?.close();
          break;
      }
    });
  }

  @override
  void onClose() {
    _snackbarController?.close();
    _subscriptionon.cancel();
    super.onClose();
  }

  TextButton _toSettingsButton() => TextButton(
        onPressed: () {
          AppSettings.openWIFISettings(asAnotherTask: true);
        },
        child: Text(
          'txt_to_settings'.tr,
          textAlign: TextAlign.center,
          style: textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            side: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
      );
}

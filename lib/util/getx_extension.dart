import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';

extension SatorGetInterface on GetInterface {
  SnackbarController snackbarMessage(
    String title,
    String message, {
    SnackbarStatusCallback? snackbarStatus,
  }) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: SatorioColor.carnation_pink.withOpacity(0.8),
      colorText: SatorioColor.darkAccent,
      duration: const Duration(seconds: 4),
      snackbarStatus: snackbarStatus,
      titleText: Text(
        title,
        style: textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          color: SatorioColor.darkAccent,
          fontSize: 14 * coefficient,
        ),
      ),
      messageText: Text(
        message,
        style: textTheme.bodyText2!.copyWith(
          color: SatorioColor.darkAccent,
          fontSize: 12 * coefficient,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: 10,
      ),
    );
  }

  SnackbarController snackbarWithButton(
    String title,
    String message, {
    IconData? iconData,
    shouldIconPulse = false,
    String? buttonText,
    VoidCallback? onButtonPressed,
    Duration? duration = const Duration(seconds: 4),
    SnackbarStatusCallback? snackbarStatus,
  }) {
    return Get.snackbar(
      title,
      message,
      icon: iconData == null
          ? null
          : Icon(
              iconData,
              color: Colors.white,
            ),
      titleText: Text(
        title,
        style: textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 14 * coefficient,
        ),
      ),
      messageText: Text(
        message,
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
      shouldIconPulse: shouldIconPulse,
      mainButton:
          buttonText == null ? null : _mainButton(buttonText, onButtonPressed),
      backgroundColor: SatorioColor.error.withOpacity(0.8),
      colorText: Colors.white,
      duration: duration,
      snackbarStatus: snackbarStatus,
    );
  }

  TextButton _mainButton(
    String mainButtonText,
    VoidCallback? onButtonPressed,
  ) =>
      TextButton(
        onPressed: onButtonPressed,
        child: Text(
          mainButtonText,
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
}

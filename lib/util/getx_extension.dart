import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satorio/domain/entities/fcm_announcement_type.dart';
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

  SnackbarController snackbarAlert(
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
      mainButton: buttonText == null
          ? null
          : _mainButton(buttonText, onButtonPressed, null),
      backgroundColor: SatorioColor.error.withOpacity(0.8),
      colorText: Colors.white,
      duration: duration,
      snackbarStatus: snackbarStatus,
    );
  }

  TextButton _mainButton(
    String mainButtonText,
    VoidCallback? onButtonPressed,
    Color? color,
  ) =>
      TextButton(
        onPressed: onButtonPressed,
        child: Text(
          mainButtonText,
          textAlign: TextAlign.center,
          style: textTheme.bodyText2!.copyWith(
            color: color == null ? Colors.white : SatorioColor.bright_grey,
            fontSize: 12 * coefficient,
          ),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            side: BorderSide(
              color: color == null ? Colors.white : color,
              width: 1,
            ),
          ),
        ),
      );

  SnackbarController snackbarNotify(
      RemoteMessage message, VoidCallback? onPressed) {
    HapticFeedback.vibrate();
    final String rmType = message.data["type"];
    return Get.snackbar(
      "${message.notification!.title}",
      "${message.notification!.body}",
      mainButton: _mainButton(
          callbackButtonText(rmType), onPressed, SatorioColor.bright_grey),
      backgroundColor: _fcmSnackbarColor(rmType).withOpacity(0.8),
      colorText: SatorioColor.darkAccent,
      duration: Duration(seconds: 4),
    );
  }

  Color _fcmSnackbarColor(String type) {
    switch (type) {
      case FCMType.newShow:
        return SatorioColor.alice_blue2;
      case FCMType.newEpisode:
        return SatorioColor.alice_blue2;
      default:
        return SatorioColor.brand;
    }
  }

  String callbackButtonText(String type) {
    switch (type) {
      case FCMType.newShow:
        return "txt_to_show".tr;
      case FCMType.newEpisode:
        return "txt_to_episode".tr;
      case AnnouncementType.show:
        return "txt_to_show".tr;
      case AnnouncementType.episode:
        return "txt_to_episode".tr;
      default:
        return "To new";
    }
  }
}

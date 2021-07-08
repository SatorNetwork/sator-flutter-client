import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class EpisodeRealmDialog extends StatelessWidget {

  final VoidCallback? onStartQuizPressed;
  final VoidCallback? onScanQrPressed;

  const EpisodeRealmDialog({Key? key, this.onStartQuizPressed, this.onScanQrPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'txt_enter_episode_realm'.tr.toUpperCase(),
              style: textTheme.headline6!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 13.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 32 * coefficient,
            ),
            Text(
              '1',
              style: textTheme.headline4!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 22.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 2 * coefficient,
            ),
            Text(
              'txt_enter_episode_realm_step_1'.tr,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 13.0 * coefficient,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 19 * coefficient,
            ),
            Text(
              '2',
              style: textTheme.headline4!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 22.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 2 * coefficient,
            ),
            Text(
              'txt_enter_episode_realm_step_2'.tr,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 13.0 * coefficient,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 19 * coefficient,
            ),
            Text(
              '3',
              style: textTheme.headline4!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 22.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 2 * coefficient,
            ),
            Text(
              'txt_enter_episode_realm_step_3'.tr,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 13.0 * coefficient,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 32 * coefficient,
            ),
            ElevatedGradientButton(
              text: 'txt_start_entrance_quiz'.tr,
              onPressed: onStartQuizPressed
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            ElevatedGradientButton(
              text: 'txt_qr_scan'.tr,
              onPressed: onScanQrPressed
            ),
          ],
        ),
      ),
    );
  }
}

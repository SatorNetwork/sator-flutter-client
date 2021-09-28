import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/color_text_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class EpisodeRealmDialog extends StatelessWidget {
  const EpisodeRealmDialog({
    Key? key,
    this.onQuizPressed,
    this.onPaidUnlockPressed,
    this.isZeroSeason = false,
  }) : super(key: key);

  final VoidCallback? onQuizPressed;
  final VoidCallback? onPaidUnlockPressed;
  final bool isZeroSeason;

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
            Container(
              height: 90 * coefficient,
              width: 90 * coefficient,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SatorioColor.alice_blue,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'images/locked_icon.svg',
                  width: 45 * coefficient,
                  color: SatorioColor.brand,
                ),
              ),
            ),
            SizedBox(
              height: 20 * coefficient,
            ),
            Text(
              'txt_to_enter_realm'.tr,
              style: textTheme.headline4!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 24.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 30 * coefficient,
            ),
            ElevatedGradientButton(
              text: 'txt_unlock_quiz'.tr,
              onPressed: () {
                Get.back();
                if (onQuizPressed != null) {
                  onQuizPressed!();
                }
              },
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            Text(
              'txt_or'.tr,
              style: textTheme.bodyText2!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 14.0 * coefficient,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            BorderedButton(
              text: 'txt_unlock_sao'.tr,
              textColor: SatorioColor.interactive,
              borderColor: SatorioColor.interactive,
              borderWidth: 2,
              onPressed: () {
                Get.back();
                if (onPaidUnlockPressed != null) {
                  onPaidUnlockPressed!();
                }
              },
            ),
            SizedBox(
              height: 8 * coefficient,
            ),
            ColorTextButton(
              text: 'txt_cancel'.tr,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

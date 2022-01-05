import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' show Get, GetNavigation;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/avatar_image.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

class SuccessTipDialog extends StatelessWidget {
  const SuccessTipDialog(
    this.name,
    this.text,
    this.title,
    this.amount,
    this.userAvatar,
    this.buttonText, {
    this.onButtonPressed,
    this.icon,
  });

  final String name;
  final String text;
  final String title;
  final double amount;
  final String userAvatar;
  final String buttonText;

  final IconData? icon;
  final VoidCallback? onButtonPressed;

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
            if (icon != null)
              Container(
                width: 36 * coefficient,
                height: 36 * coefficient,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SatorioColor.interactive,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 24 * coefficient,
                    color: Colors.white,
                  ),
                ),
              ),
            if (icon != null) SizedBox(height: 16),
            Text(
              title,
              style: textTheme.headline1!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 24.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: SatorioColor.alice_blue2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                      child: AvatarImage(
                    userAvatar,
                    height: 20,
                    width: 20,
                  )),
                  SizedBox(
                    width: 6,
                  ),
                  Flexible(
                    child: Text(
                      '$name',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText1!.copyWith(
                        color: SatorioColor.textBlack,
                        fontSize: 15.0 * coefficient,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'txt_success_tip'.tr,
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 17 * coefficient,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Flexible(
                  child: Text(
                    '$amount SAO',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1!.copyWith(
                      fontSize: 17 * coefficient,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedGradientButton(
              text: buttonText,
              onPressed: () {
                Get.back();
                onButtonPressed?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

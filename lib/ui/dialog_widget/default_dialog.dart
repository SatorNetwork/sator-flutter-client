import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, GetNavigation;
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/bordered_button.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/extension.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog(
    this.title,
    this.text,
    this.buttonText, {
    this.onButtonPressed,
    this.icon,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
  });

  final String title;
  final String text;
  final String buttonText;

  final IconData? icon;
  final VoidCallback? onButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;

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
            SizedBox(height: 8),
            Text(
              text.capitalize(),
              textAlign: TextAlign.center,
              style: textTheme.bodyText1!.copyWith(
                fontSize: 17 * coefficient,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16),
            ElevatedGradientButton(
              text: buttonText,
              onPressed: () {
                Get.back();
                onButtonPressed?.call();
              },
            ),
            if (secondaryButtonText != null && secondaryButtonText!.isNotEmpty)
              SizedBox(height: 8),
            if (secondaryButtonText != null && secondaryButtonText!.isNotEmpty)
              BorderedButton(
                text: secondaryButtonText!,
                onPressed: () {
                  Get.back();
                  onSecondaryButtonPressed?.call();
                },
                textColor: SatorioColor.interactive,
                borderColor: SatorioColor.interactive,
                borderWidth: 2,
              ),
          ],
        ),
      ),
    );
  }
}

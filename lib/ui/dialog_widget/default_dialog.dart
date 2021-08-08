import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/util/extension.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog(this.title, this.text, this.buttonText,
      {this.onPressed, this.icon});

  final String title;
  final String text;
  final String buttonText;
  final VoidCallback? onPressed;
  final IconData? icon;

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
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';

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
            icon == null
                ? SizedBox(height: 0)
                : Container(
                    width: 48 * coefficient,
                    height: 48 * coefficient,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SatorioColor.interactive,
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 32 * coefficient,
                        color: Colors.white,
                      ),
                    ),
                  ),
            SizedBox(height: icon == null ? 0 : 24),
            Text(
              title,
              style: textTheme.headline1!.copyWith(
                  color: SatorioColor.textBlack,
                  fontSize: 34.0 * coefficient,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: textTheme.bodyText1!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 24),
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

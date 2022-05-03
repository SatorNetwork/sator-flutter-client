import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class BorderedButton extends StatelessWidget {
  const BorderedButton({
    this.text = '',
    this.textColor = SatorioColor.darkAccent,
    this.backgroundColor = Colors.transparent,
    this.borderColor = SatorioColor.darkAccent,
    this.borderWidth = 1.0,
    this.icon,
    this.onPressed,
    this.isInProgress = false,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isInProgress;

  static const double minHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size.fromHeight(minHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        side: BorderSide(color: borderColor, width: borderWidth),
      ),
      child: isInProgress
          ? SizedBox(
              height: minHeight * 0.6,
              width: minHeight * 0.6,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  SatorioColor.interactive.withOpacity(0.5),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textTheme.bodyText2!.copyWith(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (icon != null)
                  SizedBox(
                    width: 12,
                  ),
                if (icon != null) icon!,
              ],
            ),
    );
  }
}

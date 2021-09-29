import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ColorTextButton extends StatelessWidget {
  const ColorTextButton({
    this.text = '',
    this.textColor = SatorioColor.interactive,
    this.onPressed,
  });

  final String text;
  final Color textColor;
  final VoidCallback? onPressed;

  static const double minHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: textTheme.bodyText2!.copyWith(
          color: textColor,
          fontSize: 18.0 * coefficient,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size.fromHeight(48),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

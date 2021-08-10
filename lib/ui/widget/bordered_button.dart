import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class BorderedButton extends StatelessWidget {
  const BorderedButton({
    this.text = '',
    this.borderColor = SatorioColor.darkAccent,
    this.icon,
    this.onPressed,
  });

  final String text;
  final Color borderColor;
  final VoidCallback? onPressed;
  final Widget? icon;

  static const double minHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: Size.fromHeight(minHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: textTheme.bodyText2!.copyWith(
              color: SatorioColor.darkAccent,
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
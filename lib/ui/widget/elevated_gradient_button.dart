import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class ElevatedGradientButton extends StatelessWidget {
  const ElevatedGradientButton({
    this.text = '',
    this.onPressed,
    this.leftColor = SatorioColor.interactive,
    this.rightColor = SatorioColor.darkAccent,
    this.isEnabled = true,
    this.isInProgress = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color leftColor;
  final Color rightColor;
  final bool isEnabled;
  final bool isInProgress;

  static const double minHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        color: isEnabled ? Colors.transparent : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onClick(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [leftColor, rightColor]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            constraints: BoxConstraints(
              minHeight: minHeight,
            ),
            alignment: Alignment.center,
            child: isInProgress
                ? SizedBox(
                    height: minHeight * 0.6,
                    width: minHeight * 0.6,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.5),
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 16.0 * coefficient,
                        fontWeight: FontWeight.w700),
                  ),
          ),
        ),
      ),
    );
  }

  VoidCallback? onClick() {
    if (isInProgress)
      return null;
    else {
      return isEnabled ? onPressed : null;
    }
  }
}

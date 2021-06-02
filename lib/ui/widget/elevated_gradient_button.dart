import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satorio/ui/theme/sator_color.dart';

class ElevatedGradientButton extends StatelessWidget {
  const ElevatedGradientButton({
    this.text,
    this.onPressed,
    this.leftColor = SatorioColor.interactive,
    this.rightColor = SatorioColor.darkAccent,
  });

  final String text;
  final Function onPressed;
  final Color leftColor;
  final Color rightColor;

  static const double minHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

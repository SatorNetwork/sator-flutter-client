import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

class TitleWithButton extends StatelessWidget {
  final String textCode;
  final Function onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? buttonText;
  final Color? color;
  final Color? iconColor;

  TitleWithButton(
      {required this.textCode,
      required this.onTap,
      this.fontSize,
      this.fontWeight,
      this.buttonText,
      this.color,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              textCode.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText1!.copyWith(
                color: color == null ? SatorioColor.darkAccent : color,
                fontSize: fontSize == null ? 15.0 : fontSize,
                fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buttonText != null
                  ? Text(
                      buttonText!,
                      style: textTheme.bodyText1!.copyWith(
                          color: SatorioColor.darkAccent,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400),
                    )
                  : Container(),
              Icon(
                Icons.chevron_right,
                size: 30,
                color: iconColor == null ? Colors.black : iconColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}

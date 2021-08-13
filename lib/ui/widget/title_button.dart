import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:get/get.dart';

class TitleWithButton extends StatelessWidget {
  final String textCode;
  final Function onTap;

  TitleWithButton({required this.textCode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(textCode.tr, style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),),
          Icon(Icons.chevron_right, size: 30,)
        ],
      ),
    );
  }
}
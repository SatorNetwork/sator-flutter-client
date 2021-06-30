import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';

final textTheme = TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 31.0 * coefficient,
        color: SatorioColor.textBlack),
    headline2:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0 * coefficient),
    headline3:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0 * coefficient),
    headline4:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0 * coefficient),
    headline5:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0 * coefficient),
    headline6:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0 * coefficient),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.0 * coefficient,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15.0 * coefficient,
    ),
    bodyText1: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 17.0 * coefficient,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15.0 * coefficient,
    ),
    button:
        TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0 * coefficient));

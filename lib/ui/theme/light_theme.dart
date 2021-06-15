import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: SatorioColor.brand,
  accentColor: SatorioColor.darkAccent,
  buttonColor: SatorioColor.interactive,
  fontFamily: 'Inter',
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      //the rounded corner is created here
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
        bottom: Radius.zero,
      ),
    ),
  ),
  textTheme:
      textTheme.copyWith(bodyText1: TextStyle(color: SatorioColor.brand)),
);

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: SatorioColor.brand,
  accentColor: SatorioColor.darkAccent,
  buttonColor: SatorioColor.interactive,
  fontFamily: 'Inter',
  textTheme:
      textTheme.copyWith(bodyText1: TextStyle(color: SatorioColor.brand)),
);

final double coefficient = Get.height / 812;



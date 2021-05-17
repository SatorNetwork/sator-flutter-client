import 'package:flutter/material.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/text_theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: SatorColor.brand,
  accentColor: SatorColor.darkAccent,
  buttonColor: SatorColor.interactive,
  fontFamily: 'Inter',
  textTheme: textTheme.copyWith(bodyText1: TextStyle(color: SatorColor.brand)),

);
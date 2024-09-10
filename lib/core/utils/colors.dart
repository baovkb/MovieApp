import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColor {
  static Color primaryColor = const Color(0xffeae6e6);
  static Color primaryColorDark = const Color(0xff0f111d);
  static Color mainLightColor = const Color(0xff1b2244);
  static Color secondaryColor = const Color(0xffb0b2b6);
  static Color secondaryColorDark = const Color(0xff1b2244);
  static Color transparentColor = const Color(0x00ffffff);
  static Color textColor = Colors.white70;
  static Color lightTextColor = Colors.white54;
  static Color errorColor = Colors.red;

  static ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: primaryColorDark,
      primaryContainer: primaryColor,
      onPrimaryContainer: primaryColor,
      secondary: secondaryColor,
      onSecondary: secondaryColor,
      error: errorColor,
      onError: errorColor,
      surface: primaryColor,
      onSurface: primaryColorDark);
  
  static ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColorDark,
      onPrimary: primaryColor,
      primaryContainer: primaryColorDark,
      onPrimaryContainer: primaryColorDark,
      secondary: secondaryColorDark,
      onSecondary: secondaryColor,
      error: errorColor,
      onError: errorColor,
      surface: primaryColorDark,
      onSurface: primaryColor);
}
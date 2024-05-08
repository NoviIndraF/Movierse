import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movierse/core/styles/colors.dart';

final TextStyle titleText =
    GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400);
final TextStyle subtitleText = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle normalText = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle bodyText = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25);

final textTheme = TextTheme(
  headline5: subtitleText,
  headline6: normalText,
  subtitle1: titleText,
  bodyText2: bodyText,
);

const colorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: primaryColor,
  secondary: accentColor,
  secondaryContainer: accentColor,
  surface: bgDark,
  background: bgDark,
  error: Colors.red,
  onPrimary: bgDark,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);

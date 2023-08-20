import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.red;
  static const Color accentColor = Colors.red;

  static TextStyle headlineTextStyle = GoogleFonts.abhayaLibre(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle bodyTextStyle = GoogleFonts.timmana(
    fontSize: 16,
    color: Colors.black87,
  );

  static final ThemeData blueTheme = ThemeData(
    primaryColor: primaryColor,
    hintColor: accentColor,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: headlineTextStyle,
      bodyLarge: bodyTextStyle,
    ),
  );
}

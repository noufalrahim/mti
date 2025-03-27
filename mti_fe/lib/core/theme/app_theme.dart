import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFFCAD2);
  static const Color secondaryColor = Color(0xFF62CDFA);
  static const Color textGray = Color(0xFF766565);
  static const Color cardBackgroundColor = Color(0xFFFFDF86);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: secondaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(secondaryColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        hintStyle: TextStyle(color: textGray, fontSize: 13),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      )
      
    );
  }
}

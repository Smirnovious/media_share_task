import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Raleway',
  brightness: Brightness.light,
  textTheme: textThemeLight,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFfaf0e6),
    primary: Color(0xFFff8c00),
    secondary: Color(0xFFff8c00),
    onPrimary: Color(0xFFfaf0e6),
  ),
);

final TextTheme textThemeLight = ThemeData.light().textTheme.copyWith(
      displayLarge: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'Raleway',
      ),
      displayMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Raleway',
      ),
      displaySmall: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'Raleway',
      ),
    );

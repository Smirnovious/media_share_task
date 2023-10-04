import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Raleway',
    brightness: Brightness.dark,
    textTheme: textTheme,
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF121212),
      primary: Color.fromARGB(255, 43, 0, 255),
    ));

final textTheme = ThemeData.dark().textTheme.copyWith(
      displayLarge: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      
    );

import 'package:flutter/material.dart';

// Primary colors
const Color primary_300 = Color(0xff1597FF);
const Color primary_200 = Color(0xff87C4FF);
const Color primary_100 = Color(0xffE0F4FF);
const Color primary_50 = Color(0xffFFEED9);

// Text colors
const Color text_900 = Color(0xff111111);
const Color text_800 = Color(0xff262626);
const Color text_700 = Color(0xff434343);
const Color text_600 = Color(0xff555555);
const Color text_500 = Color(0xff7b7b7b);
const Color text_400 = Color(0xff9d9d9d);
const Color text_300 = Color(0xffc4c4c4);
const Color text_200 = Color(0xffd9d9d9);
const Color text_100 = Color(0xffe9e9e9);
const Color text_50 = Color(0xfff5f5f5);

// Themes
class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: text_800,
      onPrimary: text_800,
      surface: text_50,
      onSurface: text_800,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontSize: 96, fontWeight: FontWeight.w300, color: text_800),
      displayMedium:
          TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: text_800),
      displaySmall:
          TextStyle(fontSize: 48, fontWeight: FontWeight.w400, color: text_800),
      headlineMedium:
          TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: text_800),
      headlineSmall:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: text_800),
      titleLarge:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: text_800),
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: text_800),
      titleSmall:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: text_800),
      bodyLarge:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: text_800),
      bodyMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: text_800),
      labelLarge:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: text_800),
      bodySmall:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: text_800),
      labelSmall:
          TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: text_800),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: text_50,
      onPrimary: text_50,
      surface: primary_300,
      onSurface: text_50,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontSize: 96, fontWeight: FontWeight.w300, color: text_50),
      displayMedium:
          TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: text_50),
      displaySmall:
          TextStyle(fontSize: 48, fontWeight: FontWeight.w400, color: text_50),
      headlineMedium:
          TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: text_50),
      headlineSmall:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: text_50),
      titleLarge:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: text_50),
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: text_50),
      titleSmall:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: text_50),
      bodyLarge:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: text_50),
      bodyMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: text_50),
      labelLarge:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: text_50),
      bodySmall:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: text_50),
      labelSmall:
          TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: text_50),
    ),
  );
}

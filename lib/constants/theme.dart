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

// More colors
const Color color_1 = Color.fromRGBO(255, 77, 64, 1);
const Color color_2 = Color(0xff46AB5E);
const Color linearColor1 = Color(0xff1597FF);
const Color linearColor2 = Color(0xff3F51B5);
const Color linearColor3 = Color(0xff00C853);

// Themes
class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primary_300,
      onPrimary: text_50,
      primaryContainer: text_100,
      secondaryContainer: text_50,
      surfaceTint: primary_300,
      surface: text_50,
      onSurface: text_500,
      outline: Colors.transparent,
      onSecondary: Colors.white,
      secondary: Colors.black,
      onSecondaryContainer: text_50,
      surfaceVariant: text_800,
      tertiary: primary_300,
    ),
    cardTheme: const CardTheme(
      color: text_50,
      surfaceTintColor: Colors.transparent,
      shadowColor: text_900,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: text_700),
      displayMedium:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: text_700),
      displaySmall:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: text_700),
      headlineLarge:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: text_700),
      headlineMedium:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: text_700),
      headlineSmall:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: text_700),
      titleLarge:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: text_700),
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: text_700),
      titleSmall:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: text_700),
      bodyLarge:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: text_700),
      bodyMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: text_700),
      bodySmall:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: text_700),
      labelLarge:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: text_700),
      labelMedium:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: text_700),
      labelSmall:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: text_700),
    ),
    iconTheme: const IconThemeData(
      color: text_500,
      size: 24.0,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: text_50,
      onPrimary: text_800,
      primaryContainer: text_800,
      secondaryContainer: text_900,
      surfaceTint: text_800,
      surface: text_800,
      onSurface: text_50,
      onSecondary: text_800,
      secondary: Colors.white,
      onSecondaryContainer: text_600,
      surfaceVariant: Colors.white,
      tertiary: text_50,
    ),
    cardTheme: const CardTheme(
      color: text_800,
      surfaceTintColor: Colors.transparent,
      shadowColor: text_600,
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: text_50),
      displayMedium:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: text_50),
      displaySmall:
          TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: text_50),
      headlineLarge:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: text_50),
      headlineMedium:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: text_50),
      headlineSmall:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: text_50),
      titleLarge:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: text_50),
      titleMedium:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: text_50),
      titleSmall:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: text_50),
      bodyLarge:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: text_50),
      bodyMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: text_50),
      bodySmall:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: text_50),
      labelLarge:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: text_50),
      labelMedium:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: text_50),
      labelSmall:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: text_50),
    ),
    iconTheme: const IconThemeData(
      color: text_100,
      size: 24.0,
    ),
  );
}

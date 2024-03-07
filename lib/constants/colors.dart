import 'package:flutter/material.dart';

// Primary color
const Color primary_300 = Color(0xff1597FF);
const Color primary_200 = Color(0xff87C4FF);
const Color primary_100 = Color(0xffE0F4FF);
const Color primary_50 = Color(0xffFFEED9);

// Text color
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

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: text_50,
      onPrimary: text_50,
      surface: primary_300,
      onSurface: text_800,
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: text_800,
      onPrimary: text_800,
      surface: Colors.deepPurple,
      onSurface: text_50,
    ),
  );
}

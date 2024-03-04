import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveMode(bool mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('theme_mode', mode);
}

Future<bool> loadMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('theme_mode') ?? false;
}

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;

  ThemeProvider() {
    loadMode().then((mode) async {
      isDarkMode = mode;
      notifyListeners();
    });
  }

  Future<void> setThemeMode(bool mode) async {
    isDarkMode = mode;
    notifyListeners();
    await saveMode(mode);
  }
}

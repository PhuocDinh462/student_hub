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
  bool _isDarkMode = false;

  bool get getThemeMode => _isDarkMode;

  ThemeProvider() {
    loadMode().then((mode) async {
      _isDarkMode = mode;
      notifyListeners();
    });
  }

  Future<void> setThemeMode(bool mode) async {
    _isDarkMode = mode;
    notifyListeners();
    await saveMode(mode);
  }
}

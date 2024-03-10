import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData({bool? mode, String? language}) async {
  final prefs = await SharedPreferences.getInstance();
  if (mode != null) await prefs.setBool('theme_mode', mode);
  if (language != null) await prefs.setString('language', language);
}

Future<Object> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'mode': prefs.getBool('theme_mode') ?? false,
    'language': prefs.getString('language') ?? 'en'
  };
}

class ThemeProvider with ChangeNotifier {
  late bool _isDarkMode;
  late String _language;

  bool get getThemeMode => _isDarkMode;
  String get getLanguage => _language;

  ThemeProvider() {
    loadData().then((data) async {
      _isDarkMode = (data as Map<String, dynamic>)['mode'];
      _language = (data)['language'];
      notifyListeners();
    });
  }

  Future<void> setThemeMode(bool mode) async {
    _isDarkMode = mode;
    notifyListeners();
    await saveData(mode: mode);
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    notifyListeners();
    await saveData(language: language);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData({ThemeMode? theme, String? language}) async {
  final prefs = await SharedPreferences.getInstance();
  if (theme != null) await prefs.setString('theme', theme.toString());
  if (language != null) await prefs.setString('language', language);
}

Future<Object> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'theme': themeModeFromString(prefs.getString('theme') ?? ''),
    'language': prefs.getString('language') ?? 'en',
  };
}

ThemeMode themeModeFromString(String theme) {
  switch (theme) {
    case 'system':
      return ThemeMode.system;
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

class ThemeProvider with ChangeNotifier {
  late String _language;
  late ThemeMode _theme;

  ThemeMode get getTheme => _theme;

  String get getThemeName {
    if (_theme == ThemeMode.light) {
      return 'Light';
    } else if (_theme == ThemeMode.dark) {
      return 'Dark';
    } else {
      return 'System';
    }
  }

  bool get getThemeMode {
    if (_theme == ThemeMode.light) {
      return false;
    } else if (_theme == ThemeMode.dark) {
      return true;
    } else {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
  }

  String get getLanguage => _language;

  ThemeProvider() {
    loadData().then((data) async {
      _theme = (data as Map)['theme'];
      _language = (data)['language'];
      notifyListeners();
    });
  }

  Future<void> setThemeMode(ThemeMode theme) async {
    _theme = theme;
    notifyListeners();
    await saveData(theme: theme);
  }

  Future<void> setLanguage(String language) async {
    _language = language;
    notifyListeners();
    await saveData(language: language);
  }
}

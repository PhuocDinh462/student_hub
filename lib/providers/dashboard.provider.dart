import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveValue(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<int> loadValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key) ?? 0;
}

class IndexPageProvider with ChangeNotifier {
  int _indexDBStudent = 0;

  IndexPageProvider() {
    loadValue('db_student').then((index) {
      _indexDBStudent = index;
      notifyListeners();
    });
  }

  int get getIndexDBStudent => _indexDBStudent;

  Future<void> setIndexDBStudent(int index) async {
    _indexDBStudent = index;
    notifyListeners();
    await saveValue('db_student', index);
  }
}

class OpenIdProvider with ChangeNotifier {
  int _openId = 0;

  int get openId => _openId;

  void setOpenId(int value) {
    _openId = value;
    notifyListeners();
  }
}

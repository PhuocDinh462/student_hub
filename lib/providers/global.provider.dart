import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  bool isFocus = false;

  void setFocus(bool value) {
    isFocus = value;
    notifyListeners();
  }
}

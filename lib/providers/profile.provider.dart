import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  int _curTechStackValue = 0;

  int get curTechStackValue => _curTechStackValue;

  void setCurTechStackValue(int value) {
    _curTechStackValue = value;
    notifyListeners();
  }
}

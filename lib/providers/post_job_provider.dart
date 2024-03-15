import 'package:flutter/material.dart';

enum TimeLine { oneToThreeMonths, threeToSixMonths }

class PostJobProvider with ChangeNotifier {
  late String _title;
  late TimeLine _timeLine;
  late int _numOfStudents;
  late String _description;

  PostJobProvider() {
    _title = '';
    _timeLine = TimeLine.oneToThreeMonths;
    _numOfStudents = 0;
    _description = '';
  }

  String get getTitle => _title;
  set setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  TimeLine get getTimeLine => _timeLine;
  set setTimeLine(TimeLine timeLine) {
    _timeLine = timeLine;
    notifyListeners();
  }

  int get getNumOfStudents => _numOfStudents;
  set setNumOfStudents(int numOfStudents) {
    _numOfStudents = numOfStudents;
    notifyListeners();
  }

  String get getDescription => _description;
  set setDescription(String description) {
    _description = description;
    notifyListeners();
  }
}

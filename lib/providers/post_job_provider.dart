import 'package:flutter/material.dart';
import 'package:student_hub/models/project.dart';

enum TimeLine { oneToThreeMonths, threeToSixMonths }

class PostJobProvider with ChangeNotifier {
  late String _title;
  late TimeLine _timeLine;
  late int _numOfStudents;
  late String _description;
  late List<Project> _projectList;

  PostJobProvider() {
    _title = '';
    _timeLine = TimeLine.oneToThreeMonths;
    _numOfStudents = 1;
    _description = '';
    _projectList = [];
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

  void addStudents() {
    _numOfStudents++;
    notifyListeners();
  }

  void removeStudents() {
    _numOfStudents--;
    notifyListeners();
  }

  String get getDescription => _description;
  set setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  List<Project> get getProjectList => _projectList;
  set setProjectList(List<Project> projectList) {
    _projectList = projectList;
    notifyListeners();
  }

  void addProject(Project project) {
    _projectList.add(project);
    notifyListeners();
  }

  void clear() {
    _title = '';
    _timeLine = TimeLine.oneToThreeMonths;
    _numOfStudents = 1;
    _description = '';
    notifyListeners();
  }
}

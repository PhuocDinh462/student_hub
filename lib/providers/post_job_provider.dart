import 'package:flutter/material.dart';
import 'package:student_hub/models/project.dart';

class PostJobProvider with ChangeNotifier {
  late String _title;
  late ProjectScopeFlag _projectScope;
  late int _numOfStudents;
  late String _description;
  late List<Project> _projectList;
  Project? _currentProject;

  PostJobProvider() {
    _title = '';
    _projectScope = ProjectScopeFlag.oneToThreeMonth;
    _numOfStudents = 1;
    _description = '';
    _projectList = [];
  }

  String get getTitle => _title;
  set setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  ProjectScopeFlag get getProjectScope => _projectScope;
  set setProjectScope(ProjectScopeFlag projectScope) {
    _projectScope = projectScope;
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

  Project? get getCurrentProject => _currentProject;
  set setCurrentProject(Project project) {
    _currentProject = project;
    notifyListeners();
  }

  void clear() {
    _title = '';
    _projectScope = ProjectScopeFlag.oneToThreeMonth;
    _numOfStudents = 1;
    _description = '';
    notifyListeners();
  }
}

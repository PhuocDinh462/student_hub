import 'package:flutter/material.dart';
import 'package:student_hub/models/user.dart';

class UserProvider with ChangeNotifier {
  User?
      _currentUser; // User hiện tại đang đăng nhập, có thể null nếu không có user nào đăng nhập

  UserProvider(User? currentUser) {
    _currentUser = currentUser;
  }

  // Getter cho currentUser
  User? get currentUser => _currentUser;

  // Setter cho currentUser
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}

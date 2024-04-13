import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void setCurrentUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', user.token);
    await prefs.setInt('role', user.currentRole.index);
    _currentUser = user;
    notifyListeners();
  }
}

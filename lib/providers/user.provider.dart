import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/api/services/api.services.dart';
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

  void removeCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
    await prefs.remove('token');
    _currentUser = null;
    notifyListeners();
  }

  void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> initializeProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final AuthService authService = AuthService();
    int? role = prefs.getInt('role');
    String? token = prefs.getString('token');
    if (role != null && token != null) {
      final userInfo = await authService.getMe();
      final companyId =
          userInfo['company'] != null ? userInfo['company']['id'] : null;
      final studentId =
          userInfo['student'] != null ? userInfo['student']['id'] : null;
      List<Role> roles = [];

      for (var role in userInfo['roles']) {
        roles.add(role == 0 ? Role.student : Role.company);
      }

      User user = User(
        userId: userInfo['id'],
        fullname: userInfo['fullname'],
        roles: roles,
        currentRole: Role.values[role],
        companyId: companyId,
        studentId: studentId,
        token: token,
      );

      _currentUser = user;
    }

    // notifyListeners();
  }
}

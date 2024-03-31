import 'package:flutter/material.dart';
import 'package:student_hub/models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = []; // Danh sách các user
  User?
      _currentUser; // User hiện tại đang đăng nhập, có thể null nếu không có user nào đăng nhập

  // Getter cho danh sách users
  List<User> get users => _users;

  // Getter cho currentUser
  User? get currentUser => _currentUser;

  // Setter cho danh sách users
  void setUsers(List<User> users) {
    _users = users;
    notifyListeners();
  }

  // Setter cho currentUser
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  // Phương thức để thêm một user vào danh sách users
  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  // Phương thức để cập nhật thông tin của user trong danh sách users
  void updateUser(User user) {
    final index = _users.indexWhere((element) => element.userId == user.userId);
    if (index != -1) {
      _users[index] = user;
      notifyListeners();
    }
  }

  // Phương thức để xóa một user khỏi danh sách users
  void removeUser(User user) {
    _users.removeWhere((element) => element.userId == user.userId);
    notifyListeners();
  }
}

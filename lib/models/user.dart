import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum UserType {
  student,
  company,
}

// Khai báo enum Role
enum Role { student, company }

class User extends Equatable {
  final int userId;
  final String fullname;
  // final String email;
  final Role role;
  final String token;
  final int? companyId;
  final int? studentId;

  // Constructor
  const User({
    required this.userId,
    required this.fullname,
    // required this.email,
    required this.role,
    required this.token,
    this.companyId,
    this.studentId,
  });

  @override
  List<Object?> get props => [userId, fullname, role, token];

  User copyWith({
    int? userId,
    String? fullname,
    // String? email,
    Role? role,
    String? token,
    int? companyId,
    int? studentId,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      // email: email ?? this.email,
      role: role ?? this.role,
      token: token ?? this.token,
      companyId: companyId ?? this.companyId,
      studentId: studentId ?? this.studentId,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      fullname: map['fullname'],
      // email: map['email'],
      role: Role.values[map['role']],
      token: map['token'],
      companyId: map['companyId'],
      studentId: map['studentId'],
    );
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? const Uuid().v4(),
      fullname: json['fullname'] ?? '',
      role: Role.values[json['role']],
      token: json['token'],
      companyId: json['companyId'],
      studentId: json['studentId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullname': fullname,
      // 'email': email,
      'role': role.index,
      'token': token,
      'companyId': companyId,
      'studentId': studentId,
    };
  }
}

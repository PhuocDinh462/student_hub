import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Khai báo enum Role
enum Role { student, company }

class User extends Equatable {
  final int userId;
  final String fullname;
  // final String email;
  final List<Role> roles;
  final Role currentRole;
  final String? token;
  final int? companyId;
  final int? studentId;

  // Constructor
  const User({
    required this.userId,
    required this.fullname,
    // required this.email,
    required this.roles,
    required this.currentRole,
    this.token,
    this.companyId,
    this.studentId,
  });

  @override
  List<Object?> get props => [userId, fullname, roles, currentRole, token];

  User copyWith({
    int? userId,
    String? fullname,
    // String? email,
    List<Role>? roles,
    Role? currentRole,
    String? token,
    int? companyId,
    int? studentId,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      // email: email ?? this.email,
      roles: roles ?? this.roles,
      currentRole: currentRole ?? this.currentRole,
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
      roles: map['roles'],
      currentRole: Role.values[map['currentRole']],
      token: map['token'] as String?,
      companyId: map['companyId'],
      studentId: map['studentId'],
    );
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? const Uuid().v4(),
      fullname: json['fullname'] ?? '',
      roles: json['roles'],
      currentRole: Role.values[json['currentRole']],
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
      'roles': roles,
      'currentRole': currentRole.index,
      'token': token,
      'companyId': companyId,
      'studentId': studentId,
    };
  }
}

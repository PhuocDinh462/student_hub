// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:student_hub/models/models.dart';

enum UserRole { student, company }

class UserModel extends BaseModel {
  final String? email;
  final String? fullname;
  final bool? verified;
  final bool? isConfirmed;
  final List<UserRole>? roles;

  const UserModel({
    this.email = '',
    this.fullname = '',
    this.verified = false,
    this.isConfirmed = false,
    this.roles = const [],
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  UserModel copyWith({
    String? email,
    String? fullname,
    bool? verified,
    bool? isConfirmed,
    List<UserRole>? roles,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return UserModel(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      verified: verified ?? this.verified,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      roles: roles ?? this.roles,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullname': fullname,
      'verified': verified,
      'isConfirmed': isConfirmed,
      'roles': roles!.map((x) => x).toList(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String?,
      fullname: map['fullname'] as String?,
      verified: map['verified'] as bool?,
      isConfirmed: map['isConfirmed'] as bool?,
      roles: map['roles'] == null
          ? null
          : List<UserRole>.from(
              (map['roles'] as List<dynamic>).map<UserRole>(
                (x) => UserRole.values[x],
              ),
            ),
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, fullname: $fullname, verified: $verified, isConfirmed: $isConfirmed, roles: $roles)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.fullname == fullname &&
        other.verified == verified &&
        other.isConfirmed == isConfirmed &&
        listEquals(other.roles, roles);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        fullname.hashCode ^
        verified.hashCode ^
        isConfirmed.hashCode ^
        roles.hashCode;
  }
}

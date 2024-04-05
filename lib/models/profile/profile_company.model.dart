import 'dart:convert';

import 'package:student_hub/models/models.dart';

class ProfileCompanyModel extends BaseModel {
  final int userId;
  final String companyName;
  final int size;
  final String website;
  final String description;

  const ProfileCompanyModel({
    this.userId = -1,
    this.companyName = '',
    this.size = 0,
    this.website = '',
    this.description = '',
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  ProfileCompanyModel copyWith({
    int? userId,
    String? companyName,
    int? size,
    String? website,
    String? description,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return ProfileCompanyModel(
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      size: size ?? this.size,
      website: website ?? this.website,
      description: description ?? this.description,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'companyName': companyName,
      'size': size,
      'website': website,
      'description': description,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory ProfileCompanyModel.fromMap(Map<String, dynamic> map) {
    return ProfileCompanyModel(
      userId: map['userId'] as int,
      companyName: map['companyName'] as String,
      size: map['size'] as int,
      website: map['website'] as String,
      description: map['description'] as String,
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String,
      deleteAt: map['updatedAt'] ?? map['deleteAt'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory ProfileCompanyModel.fromJson(String source) =>
      ProfileCompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ProfileCompanyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.userId == userId &&
        other.companyName == companyName &&
        other.size == size &&
        other.website == website &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        userId.hashCode ^
        companyName.hashCode ^
        size.hashCode ^
        website.hashCode ^
        description.hashCode;
  }
}

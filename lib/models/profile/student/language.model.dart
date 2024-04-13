import 'dart:convert';

import 'package:student_hub/models/models.dart';

class LanguageModel extends BaseModel {
  final int studentId;
  final String languageName;
  final String level;
  final bool isEdit;

  const LanguageModel({
    this.studentId = -1,
    this.languageName = '',
    this.level = '',
    this.isEdit = false,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  LanguageModel copyWith({
    int? studentId,
    String? languageName,
    String? level,
    bool? isEdit,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return LanguageModel(
      studentId: studentId ?? this.studentId,
      languageName: languageName ?? this.languageName,
      level: level ?? this.level,
      isEdit: isEdit ?? this.isEdit,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'languageName': languageName,
      'level': level,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      studentId: map['studentId'] as int,
      languageName: map['languageName'] as String,
      level: map['level'] as String,
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String,
      deleteAt: map['updatedAt'] ?? map['deleteAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) =>
      LanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LanguageModel(languageName: $languageName, level: $level)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LanguageModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.studentId == studentId &&
        other.languageName == languageName &&
        other.level == level;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deleteAt.hashCode ^
      studentId.hashCode ^
      languageName.hashCode ^
      level.hashCode;
}

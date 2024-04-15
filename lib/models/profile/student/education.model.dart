import 'dart:convert';

import 'package:student_hub/models/models.dart';

class EducationModel extends BaseModel {
  final int studentId;
  final String schoolName;
  final int startYear;
  final int endYear;
  final bool isEdit;

  const EducationModel({
    this.studentId = -1,
    this.schoolName = '',
    this.startYear = 2024,
    this.endYear = 2024,
    this.isEdit = false,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  EducationModel copyWith({
    int? studentId,
    String? schoolName,
    int? startYear,
    int? endYear,
    bool? isEdit,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return EducationModel(
      studentId: studentId ?? this.studentId,
      schoolName: schoolName ?? this.schoolName,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
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
      'schoolName': schoolName,
      'startYear': startYear,
      'endYear': endYear,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      studentId: map['studentId'] as int,
      schoolName: map['schoolName'] as String,
      startYear: map['startYear'] as int,
      endYear: map['endYear'] as int,
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationModel.fromJson(String source) =>
      EducationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EducationModel(studentId: $studentId, schoolName: $schoolName, startYear: $startYear, endYear: $endYear)';
  }

  @override
  bool operator ==(covariant EducationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.studentId == studentId &&
        other.schoolName == schoolName &&
        other.startYear == startYear &&
        other.endYear == endYear;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        studentId.hashCode ^
        schoolName.hashCode ^
        startYear.hashCode ^
        endYear.hashCode;
  }
}

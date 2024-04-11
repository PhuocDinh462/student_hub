import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:student_hub/models/models.dart';

class ExperienceModel extends BaseModel {
  final int studentId;
  final String title;
  final String startMonth;
  final String endMonth;
  final String description;
  final List<TechnicalModel> skillSets;
  final bool isEdit;

  const ExperienceModel({
    this.studentId = -1,
    this.title = '',
    this.startMonth = '',
    this.endMonth = '',
    this.description = '',
    this.skillSets = const [],
    this.isEdit = false,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  ExperienceModel copyWith({
    int? studentId,
    String? title,
    String? startMonth,
    String? endMonth,
    String? description,
    List<TechnicalModel>? skillSets,
    bool? isEdit,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return ExperienceModel(
      studentId: studentId ?? this.studentId,
      title: title ?? this.title,
      startMonth: startMonth ?? this.startMonth,
      endMonth: endMonth ?? this.endMonth,
      description: description ?? this.description,
      skillSets: skillSets ?? this.skillSets,
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
      'title': title,
      'startMonth': startMonth,
      'endMonth': endMonth,
      'description': description,
      'skillSets': skillSets.map((x) => x.toMap()).toList(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory ExperienceModel.fromMap(Map<String, dynamic> map) {
    return ExperienceModel(
      studentId: map['studentId'] as int,
      title: map['title'] as String,
      startMonth: map['startMonth'] as String,
      endMonth: map['endMonth'] as String,
      description: map['description'] as String,
      skillSets: List<TechnicalModel>.from(
        (map['skillSets'] as List).map<TechnicalModel>(
          (x) => TechnicalModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deleteAt: map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExperienceModel.fromJson(String source) =>
      ExperienceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExperienceModel(studentId: $studentId, title: $title, startMonth: $startMonth, endMonth: $endMonth, description: $description)';
  }

  @override
  bool operator ==(covariant ExperienceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.studentId == studentId &&
        other.title == title &&
        other.startMonth == startMonth &&
        other.endMonth == endMonth &&
        other.description == description &&
        listEquals(other.skillSets, skillSets);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        studentId.hashCode ^
        title.hashCode ^
        startMonth.hashCode ^
        endMonth.hashCode ^
        skillSets.hashCode ^
        description.hashCode;
  }
}

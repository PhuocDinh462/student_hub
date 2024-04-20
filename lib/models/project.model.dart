import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:student_hub/models/models.dart';

// enum ProjectScopeFlag {
//   lessThanOneMOnth,
//   oneToThreeMonth,
//   threeToSixMonth,
//   moreThanSixMOnth,
// }

// enum TypeFlag {
//   working,
//   archieved,
// }

class ProjectModel extends BaseModel {
  final int companyId;
  final ProjectScopeFlag projectScopeFlag;
  final String title;
  final String description;
  final int numberOfStudents;
  final TypeFlag typeFlag;
  final List<ProposalModel>? proposals;

  const ProjectModel({
    this.companyId = -1,
    this.projectScopeFlag = ProjectScopeFlag.lessThanOneMonth,
    this.title = '',
    this.description = '',
    this.numberOfStudents = 0,
    this.typeFlag = TypeFlag.working,
    this.proposals = const [],
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  ProjectModel copyWith({
    int? companyId,
    ProjectScopeFlag? projectScopeFlag,
    String? title,
    String? description,
    int? numberOfStudents,
    TypeFlag? typeFlag,
    List<ProposalModel>? proposals,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return ProjectModel(
      companyId: companyId ?? this.companyId,
      projectScopeFlag: projectScopeFlag ?? this.projectScopeFlag,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfStudents: numberOfStudents ?? this.numberOfStudents,
      typeFlag: typeFlag ?? this.typeFlag,
      proposals: proposals ?? this.proposals,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'description': description,
      'numberOfStudents': numberOfStudents,
      'typeFlag': typeFlag,
      'proposals': proposals?.map((x) => x.toMap()).toList(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      companyId: int.tryParse(map['companyId'].toString())!,
      projectScopeFlag: ProjectScopeFlag.values[map['projectScopeFlag'] as int],
      title: map['title'] as String,
      description: map['description'] as String,
      numberOfStudents: map['numberOfStudents'] as int,
      typeFlag: TypeFlag.values[map['typeFlag'] as int],
      proposals: map['proposals'] != null
          ? List<ProposalModel>.from(
              (map['proposals'] as List).map<ProposalModel>(
                (x) => ProposalModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(companyId: $companyId, projectScopeFlag: $projectScopeFlag, title: $title, description: $description, numberOfStudents: $numberOfStudents, typeFlag: $typeFlag, proposals: $proposals)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.companyId == companyId &&
        other.projectScopeFlag == projectScopeFlag &&
        other.title == title &&
        other.description == description &&
        other.numberOfStudents == numberOfStudents &&
        other.typeFlag == typeFlag &&
        listEquals(other.proposals, proposals);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        companyId.hashCode ^
        projectScopeFlag.hashCode ^
        title.hashCode ^
        description.hashCode ^
        numberOfStudents.hashCode ^
        typeFlag.hashCode ^
        proposals.hashCode;
  }
}

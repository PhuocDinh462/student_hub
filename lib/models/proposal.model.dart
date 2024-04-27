// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:student_hub/models/models.dart';

enum StatusFlag {
  waiting,
  active,
  offer,
  hired,
}

enum DisableFlag {
  enable,
  disable,
}

class ProposalModel extends BaseModel {
  final int projectId;
  final int studentId;
  final String coverLetter;
  final StatusFlag statusFlag;
  final DisableFlag disableFlag;
  final ProjectModel? project;
  final ProfileStudentModel? student;

  const ProposalModel({
    this.projectId = -1,
    this.studentId = -1,
    this.coverLetter = '',
    this.statusFlag = StatusFlag.waiting,
    this.disableFlag = DisableFlag.enable,
    this.project = const ProjectModel(),
    this.student = const ProfileStudentModel(),
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  ProposalModel copyWith({
    int? projectId,
    int? studentId,
    String? coverLetter,
    StatusFlag? statusFlag,
    DisableFlag? disableFlag,
    ProjectModel? project,
    ProfileStudentModel? student,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return ProposalModel(
      projectId: projectId ?? this.projectId,
      studentId: studentId ?? this.studentId,
      coverLetter: coverLetter ?? this.coverLetter,
      statusFlag: statusFlag ?? this.statusFlag,
      disableFlag: disableFlag ?? this.disableFlag,
      project: project ?? this.project,
      student: student ?? this.student,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectId': projectId,
      'studentId': studentId,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
      'disableFlag': disableFlag,
      'project': project?.toMap(),
      'student': student?.toMap(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory ProposalModel.fromMap(Map<String, dynamic> map) {
    return ProposalModel(
      projectId: map['projectId'] as int,
      studentId: map['studentId'] as int,
      coverLetter: map['coverLetter'] as String,
      statusFlag: StatusFlag.values[map['statusFlag'] as int],
      disableFlag: DisableFlag.values[map['disableFlag'] as int],
      project: map['project'] == null
          ? null
          : ProjectModel.fromMap(map['project'] as Map<String, dynamic>),
      student: map['student'] != null
          ? ProfileStudentModel.fromMap(map['student'] as Map<String, dynamic>)
          : null,
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProposalModel.fromJson(String source) =>
      ProposalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProposalModel(projectId: $projectId, studentId: $studentId, coverLetter: $coverLetter, statusFlag: $statusFlag, disableFlag: $disableFlag, project: $project, student: $student)';
  }

  @override
  bool operator ==(covariant ProposalModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.projectId == projectId &&
        other.studentId == studentId &&
        other.coverLetter == coverLetter &&
        other.statusFlag == statusFlag &&
        other.disableFlag == disableFlag &&
        other.project == project &&
        other.student == student;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        projectId.hashCode ^
        studentId.hashCode ^
        coverLetter.hashCode ^
        statusFlag.hashCode ^
        disableFlag.hashCode ^
        project.hashCode ^
        student.hashCode;
  }
}

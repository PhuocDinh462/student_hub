import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:student_hub/models/models.dart';

class ProfileStudentModel extends BaseModel {
  final int userId;

  final String? resume;
  final String? transcript;
  final TechnicalModel techStack;
  final List<TechnicalModel> skillSets;
  final List<EducationModel> educations;
  final List<ExperienceModel> experiences;
  final List<LanguageModel> languages;

  const ProfileStudentModel({
    this.userId = -1,
    this.resume = '',
    this.transcript = '',
    this.techStack = const TechnicalModel(),
    this.skillSets = const [],
    this.educations = const [],
    this.experiences = const [],
    this.languages = const [],
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  ProfileStudentModel copyWith({
    int? userId,
    String? resume,
    String? transcript,
    TechnicalModel? techStack,
    List<TechnicalModel>? skillSets,
    List<EducationModel>? educations,
    List<ExperienceModel>? experiences,
    List<LanguageModel>? languages,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return ProfileStudentModel(
      userId: userId ?? this.userId,
      resume: resume ?? this.resume,
      transcript: transcript ?? this.transcript,
      techStack: techStack ?? this.techStack,
      skillSets: skillSets ?? this.skillSets,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      languages: languages ?? this.languages,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'resume': resume,
      'transcript': transcript,
      'techStack': techStack.toMap(),
      'skillSets': skillSets.map((x) => x.toMap()).toList(),
      'educations': educations.map((x) => x.toMap()).toList(),
      'experiences': experiences.map((x) => x.toMap()).toList(),
      'languages': languages.map((x) => x.toMap()).toList(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory ProfileStudentModel.fromMap(Map<String, dynamic> map) {
    return ProfileStudentModel(
      userId: map['userId'] as int,
      resume: map['resume'] ?? map['resume'] as String?,
      transcript: map['transcript'] ?? map['transcript'] as String?,
      techStack:
          TechnicalModel.fromMap(map['techStack'] as Map<String, dynamic>),
      skillSets: List<TechnicalModel>.from(
        (map['skillSets'] as List).map<TechnicalModel>(
          (x) => TechnicalModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      educations: List<EducationModel>.from(
        (map['educations'] as List).map<EducationModel>(
          (x) => EducationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      experiences: List<ExperienceModel>.from(
        (map['experiences'] as List).map<ExperienceModel>(
          (x) => ExperienceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      languages: List<LanguageModel>.from(
        (map['languages'] as List).map<LanguageModel>(
          (x) => LanguageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileStudentModel.fromJson(String source) =>
      ProfileStudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileStudentModel(userId: $userId, resume: $resume, transcript: $transcript, techStack: $techStack, skillSets: $skillSets, educations: $educations, experiences: $experiences, languages: $languages)';
  }

  @override
  bool operator ==(covariant ProfileStudentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.userId == userId &&
        other.resume == resume &&
        other.transcript == transcript &&
        other.techStack == techStack &&
        listEquals(other.skillSets, skillSets) &&
        listEquals(other.educations, educations) &&
        listEquals(other.experiences, experiences) &&
        listEquals(other.languages, languages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        userId.hashCode ^
        resume.hashCode ^
        transcript.hashCode ^
        techStack.hashCode ^
        skillSets.hashCode ^
        educations.hashCode ^
        experiences.hashCode ^
        languages.hashCode;
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:student_hub/models/models.dart';

class ProfileStudentModel {
  final int userId;
  final String email;
  final String fullname;
  final String? resume;
  final String? transcript;
  final TechnicalModel techStack;
  final List<TechnicalModel> skillSets;
  final List<EducationModel> educations;
  final List<ExperienceModel> experiences;
  final List<LanguageModel> languages;

  const ProfileStudentModel({
    this.userId = -1,
    this.email = '',
    this.fullname = '',
    this.resume = '',
    this.transcript = '',
    this.techStack = const TechnicalModel(),
    this.skillSets = const [],
    this.educations = const [],
    this.experiences = const [],
    this.languages = const [],
  });

  ProfileStudentModel copyWith({
    int? userId,
    String? email,
    String? fullname,
    String? resume,
    String? transcript,
    TechnicalModel? techStack,
    List<TechnicalModel>? skillSets,
    List<EducationModel>? educations,
    List<ExperienceModel>? experiences,
    List<LanguageModel>? languages,
  }) {
    return ProfileStudentModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      resume: resume ?? this.resume,
      transcript: transcript ?? this.transcript,
      techStack: techStack ?? this.techStack,
      skillSets: skillSets ?? this.skillSets,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'email': email,
      'fullname': fullname,
      'resume': resume,
      'transcript': transcript,
      'techStack': techStack.toMap(),
      'skillSets': skillSets.map((x) => x.toMap()).toList(),
      'educations': educations.map((x) => x.toMap()).toList(),
      'experiences': experiences.map((x) => x.toMap()).toList(),
      'languages': languages.map((x) => x.toMap()).toList(),
    };
  }

  factory ProfileStudentModel.fromMap(Map<String, dynamic> map) {
    return ProfileStudentModel(
      userId: map['userId'] as int,
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      resume: map['resume'] as String?,
      transcript: map['transcript'] as String?,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileStudentModel.fromJson(String source) =>
      ProfileStudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileStudentModel(userId: $userId, email: $email, fullname: $fullname, resume: $resume, transcript: $transcript, techStack: $techStack, skillSets: $skillSets, educations: $educations, experiences: $experiences, languages: $languages)';
  }

  @override
  bool operator ==(covariant ProfileStudentModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.email == email &&
        other.fullname == fullname &&
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
    return userId.hashCode ^
        email.hashCode ^
        fullname.hashCode ^
        resume.hashCode ^
        transcript.hashCode ^
        techStack.hashCode ^
        skillSets.hashCode ^
        educations.hashCode ^
        experiences.hashCode ^
        languages.hashCode;
  }
}

import 'package:student_hub/models/models.dart';

class Proposal {
  final int id;
  final String coverLetter;
  StatusFlag statusFlag;
  final int projectId;
  final int studentId;
  final String studentName;
  final UserModel? user;
  final TechnicalModel techStack;
  final String resume;
  final String transcript;
  final List<EducationModel> educations;
  final List<TechnicalModel> skillSets;

  Proposal({
    required this.id,
    required this.coverLetter,
    required this.statusFlag,
    required this.projectId,
    required this.studentId,
    required this.studentName,
    this.user,
    required this.techStack,
    required this.resume,
    required this.transcript,
    required this.educations,
    required this.skillSets,
  });

  static Proposal fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      coverLetter: map['coverLetter'] ?? '',
      statusFlag: StatusFlag.values[map['statusFlag']],
      projectId: map['projectId'],
      studentId: map['student']['id'],
      studentName: map['student']['user']['fullname'] ?? '',
      user: map['student']['user']['id'] != null
          ? UserModel.fromMap(map['student']['user'])
          : null,
      techStack: TechnicalModel.fromMap(map['student']['techStack']),
      resume: map['student']['resume']?.split('resumes/')[1] ?? '',
      transcript: map['student']['transcript']?.split('transcripts/')[1] ?? '',
      educations: map['student']['educations'] != null
          ? List<EducationModel>.from(
              map['student']['educations']
                  .map((education) => EducationModel.fromMap(education)),
            )
          : [],
      skillSets: map['student']['skillSets'] != null
          ? List<TechnicalModel>.from(
              map['student']['skillSets']
                  .map((skillSet) => TechnicalModel.fromMap(skillSet)),
            )
          : [],
    );
  }
}

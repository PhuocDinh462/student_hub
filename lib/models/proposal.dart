import 'package:student_hub/models/models.dart';

enum StatusFlag { waiting, offer, hired }

class Proposal {
  final int id;
  final String coverLetter;
  final StatusFlag statusFlag;
  final int projectId;
  final int studentId;
  final String studentName;
  final TechnicalModel techStack;
  final String resume;
  final String transcript;
  final List<EducationModel> educations;

  Proposal({
    required this.id,
    required this.coverLetter,
    required this.statusFlag,
    required this.projectId,
    required this.studentId,
    required this.studentName,
    required this.techStack,
    required this.resume,
    required this.transcript,
    required this.educations,
  });

  static Proposal fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      coverLetter: map['coverLetter'] ?? '',
      statusFlag: StatusFlag.values[map['statusFlag']],
      projectId: map['projectId'],
      studentId: map['student']['id'],
      studentName: map['student']['user']['fullname'] ?? '',
      techStack: TechnicalModel.fromMap(map['student']['techStack']),
      resume: map['student']['resume'].split('resumes/')[1] ?? '',
      transcript: map['student']['transcript'].split('transcripts/')[1] ?? '',
      educations: List<EducationModel>.from(
        map['student']['educations']
            .map((education) => EducationModel.fromMap(education)),
      ),
    );
  }
}

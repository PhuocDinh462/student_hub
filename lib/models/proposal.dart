import 'package:student_hub/models/models.dart';
import 'package:student_hub/utils/helpers.dart';

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
  final String resumeLink;
  final String transcriptLink;

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
    required this.resumeLink,
    required this.transcriptLink,
  });

  static Proposal fromMap(Map<String, dynamic> map) {
    String? resumeRaw = map['student']['resume'];
    List<String> resume =
        resumeRaw != null ? Helpers.getFileNameAndExtension(resumeRaw) : [];
    String? transcriptRaw = map['student']['transcript'];
    List<String> transcript = transcriptRaw != null
        ? Helpers.getFileNameAndExtension(transcriptRaw)
        : [];

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
      // resume: map['student']['resume']?.split('resumes/')[1] ?? '',
      resume: resume.isEmpty ? '' : '${resume[0]}.${resume[1]}',
      transcript: transcript.isEmpty ? '' : '${transcript[0]}.${transcript[1]}',
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
      resumeLink: map['student']['resumeLink'] ?? '',
      transcriptLink: map['student']['transcriptLink'] ?? '',
    );
  }
}

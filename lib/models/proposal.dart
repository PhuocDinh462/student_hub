enum StatusFlag { waiting, offer, hired }

class Proposal {
  final int id;
  final String coverLetter;
  final StatusFlag statusFlag;
  final int projectId;
  final int studentId;
  final String studentName;
  final String techStackName;

  Proposal({
    required this.id,
    required this.coverLetter,
    required this.statusFlag,
    required this.projectId,
    required this.studentId,
    required this.studentName,
    required this.techStackName,
  });

  static Proposal fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'],
      coverLetter: map['coverLetter'],
      statusFlag: StatusFlag.values[map['statusFlag']],
      projectId: map['projectId'],
      studentId: map['student']['id'],
      studentName: map['student']['user']['fullname'],
      techStackName: map['student']['techStack']['name'],
    );
  }
}

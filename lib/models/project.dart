enum ProjectScopeFlag { oneToThreeMonth, threeToSixMonth }

enum TypeFlag {
  working,
  archieved,
}

class Project {
  final int id;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String title;
  final ProjectScopeFlag completionTime;
  final int requiredStudents;
  final String description;
  final List<String> proposals;
  bool favorite;
  final int countProposals;
  final int countMessages;
  final int countHired;

  Project({
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.title,
    required this.completionTime,
    required this.requiredStudents,
    required this.description,
    required this.proposals,
    required this.favorite,
    this.countProposals = 0,
    this.countMessages = 0,
    this.countHired = 0,
  });
}

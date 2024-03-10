class Project {
  final DateTime createdAt;
  final String name;
  final String completionTime;
  final int requiredStudents;
  final String description;
  final List<String> proposals;
  bool favorite;

  Project({
    required this.createdAt,
    required this.name,
    required this.completionTime,
    required this.requiredStudents,
    required this.description,
    required this.proposals,
    required this.favorite,
  });
}

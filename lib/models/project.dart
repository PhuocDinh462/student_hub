enum ProjectScopeFlag {
  lessThanOneMonth,
  oneToThreeMonth,
  threeToSixMonth,
  moreThanSixMonth
}

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
  final dynamic proposals;
  bool favorite;
  final int countProposals;
  final int countMessages;
  final int countHired;
  final TypeFlag typeFlag;

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
    this.typeFlag = TypeFlag.working,
  });

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? map['projectId'],
      createdAt: DateTime.parse(map['createdAt']),
      deletedAt:
          map['deletedAt'] == null ? null : DateTime.parse(map['deletedAt']),
      title: map['title'],
      completionTime: ProjectScopeFlag.values[map['projectScopeFlag']],
      requiredStudents: map['numberOfStudents'],
      description: map['description'],
      proposals: [],
      favorite: false,
      countProposals: map['countProposals'] ?? 0,
      countMessages: map['countMessages'] ?? 0,
      countHired: map['countHired'] ?? 0,
      typeFlag: TypeFlag.values[map['typeFlag']],
    );
  }

  static Project fromMapInProjectsList(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? map['projectId'],
      createdAt: DateTime.parse(map['createdAt']),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      title: map['title'],
      completionTime: ProjectScopeFlag.values[map['projectScopeFlag']],
      requiredStudents: map['numberOfStudents'] ?? 0,
      description: map['description'],
      proposals: [],
      favorite: map['isFavorite'] ?? false,
      countProposals: map['countProposals'],
      countMessages: 0,
      countHired: 0,
      typeFlag: map['typeFlag'] != null
          ? TypeFlag.values[map['typeFlag']]
          : TypeFlag.working,
    );
  }

  static Project fromMapInProjectsSavedList(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? map['projectId'],
      createdAt: DateTime.parse(map['createdAt']),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      title: map['title'],
      completionTime: ProjectScopeFlag.values[map['projectScopeFlag']],
      requiredStudents: map['numberOfStudents'] ?? 0,
      description: map['description'],
      proposals: [],
      favorite: true,
      countProposals: map['countProposals'],
      countMessages: 0,
      countHired: 0,
      typeFlag: map['typeFlag'] != null
          ? TypeFlag.values[map['typeFlag']]
          : TypeFlag.working,
    );
  }

  String completionTimeString() {
    switch (completionTime) {
      case ProjectScopeFlag.lessThanOneMonth:
        return 'Less than 1 month';
      case ProjectScopeFlag.oneToThreeMonth:
        return '1 to 3 months';
      case ProjectScopeFlag.threeToSixMonth:
        return '3 to 6 months';
      case ProjectScopeFlag.moreThanSixMonth:
        return 'More than 6 months';
    }
  }
}

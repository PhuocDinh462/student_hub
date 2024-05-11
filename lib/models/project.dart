import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProjectScopeFlag {
  lessThanOneMonth,
  oneToThreeMonth,
  threeToSixMonth,
  moreThanSixMonth
}

enum TypeFlag {
  newType,
  working,
  archived,
}

enum ProjectStatusFlag {
  working,
  success,
  fail,
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
  int countHired;
  final TypeFlag? typeFlag;
  final ProjectStatusFlag? statusFlag;

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
    this.typeFlag = TypeFlag.newType,
    this.statusFlag = ProjectStatusFlag.working,
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
      statusFlag: map['status'] != null
          ? ProjectStatusFlag.values[map['status']]
          : null,
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
      typeFlag:
          map['typeFlag'] != null ? TypeFlag.values[map['typeFlag']] : null,
      statusFlag: map['status'] != null
          ? ProjectStatusFlag.values[map['status']]
          : null,
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
      statusFlag: map['status'] != null
          ? ProjectStatusFlag.values[map['status']]
          : null,
    );
  }

  String completionTime2String(BuildContext context) {
    switch (completionTime) {
      case ProjectScopeFlag.lessThanOneMonth:
        return AppLocalizations.of(context)!.lessThanOneMonth;
      case ProjectScopeFlag.oneToThreeMonth:
        return AppLocalizations.of(context)!.oneToThreeMonths;
      case ProjectScopeFlag.threeToSixMonth:
        return AppLocalizations.of(context)!.threeToSixMonths;
      case ProjectScopeFlag.moreThanSixMonth:
        return AppLocalizations.of(context)!.moreThanSixMonths;
    }
  }

  static String projectScopeFlag2String(
      BuildContext context, ProjectScopeFlag projectScopeFlag) {
    switch (projectScopeFlag) {
      case ProjectScopeFlag.lessThanOneMonth:
        return AppLocalizations.of(context)!.lessThanOneMonth;
      case ProjectScopeFlag.oneToThreeMonth:
        return AppLocalizations.of(context)!.oneToThreeMonths;
      case ProjectScopeFlag.threeToSixMonth:
        return AppLocalizations.of(context)!.threeToSixMonths;
      case ProjectScopeFlag.moreThanSixMonth:
        return AppLocalizations.of(context)!.moreThanSixMonths;
    }
  }
}

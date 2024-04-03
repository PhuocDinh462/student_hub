import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/widgets/project_card.dart';

final List<Project> data = [
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Senior frontend developer(fintech)',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 5,
    description:
        'Description of Project 1. Description of Project 1. Description of Project 2. ',
    proposals: ['a', 'b'],
    favorite: true,
  ),
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Project 2',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 3,
    description: 'Description of Project 2',
    proposals: ['a', 'b', 'a', 'b'],
    favorite: true,
  ),
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Senior frontend developer(fintech)',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: true,
  ),
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Senior frontend developer(fintech)',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: true,
  ),
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Senior frontend developer(fintech)',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: true,
  ),
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Senior frontend developer(fintech)',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: true,
  ),
  Project(
    id: 1,
    createdAt: DateTime.now(),
    title: 'Senior frontend developer(fintech)',
    completionTime: ProjectScopeFlag.oneToThreeMonth,
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: true,
  ),
];

class ProjectsSaved extends StatefulWidget {
  const ProjectsSaved({super.key});
  @override
  State<ProjectsSaved> createState() => _ProjectsSavedState();
}

class _ProjectsSavedState extends State<ProjectsSaved> {
  final List<Project> projects = data;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(30),
              Expanded(
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(project: projects[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/widgets/project_card.dart';
import 'package:student_hub/widgets/search_field.dart';

final List<Project> data = [
  Project(
    createdAt: DateTime.now(),
    name: 'Senior frontend developer(fintech)',
    completionTime: '1-3 months',
    requiredStudents: 5,
    description:
        'Description of Project 1. Description of Project 1. Description of Project 2. ',
    proposals: ['a', 'b'],
    favorite: true,
  ),
  Project(
    createdAt: DateTime.now(),
    name: 'Project 2',
    completionTime: '1-3 months',
    requiredStudents: 3,
    description: 'Description of Project 2',
    proposals: ['a', 'b', 'a', 'b'],
    favorite: false,
  ),
  Project(
    createdAt: DateTime.now(),
    name: 'Senior frontend developer(fintech)',
    completionTime: '1-3 months',
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: false,
  ),
  Project(
    createdAt: DateTime.now(),
    name: 'Senior frontend developer(fintech)',
    completionTime: '1-3 months',
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: false,
  ),
  Project(
    createdAt: DateTime.now(),
    name: 'Senior frontend developer(fintech)',
    completionTime: '1-3 months',
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: false,
  ),
  Project(
    createdAt: DateTime.now(),
    name: 'Senior frontend developer(fintech)',
    completionTime: '1-3 months',
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: false,
  ),
  Project(
    createdAt: DateTime.now(),
    name: 'Senior frontend developer(fintech)',
    completionTime: '1-3 months',
    requiredStudents: 5,
    description: 'Description of Project 1',
    proposals: ['a', 'b'],
    favorite: false,
  ),
];

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
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
              Row(
                children: [
                  Expanded(
                    child: SearchBox(controller: searchController),
                  ),
                  IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {
                      // Handle filter button tap
                    },
                  ),
                ],
              ),
              const Gap(10),
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

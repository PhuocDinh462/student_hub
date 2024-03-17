import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/widgets/filter_projects.dart';
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
  // String _selectedMenu = '';
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
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    iconSize: 32,
                    offset: const Offset(-30, 45),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    onSelected: (String value) {
                      setState(() {
                        // _selectedMenu = value;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Saved',
                        height: 60,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.projectsSaved);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1
                                      : .7),
                            ),
                            const Gap(16),
                            Text(
                              'Saved projects',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Filter',
                        height: 60,
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              builder: (ctx) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: const FilterProject(),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1
                                      : .7),
                            ),
                            const Gap(16),
                            Text(
                              'Filter projects',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Cancel', // Giá trị cho mục "Cancel"
                        height: 60,
                        onTap: () {
                          // Xử lý khi chọn "Cancel"
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1
                                      : .7),
                            ),
                            const Gap(16),
                            Text(
                              'Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

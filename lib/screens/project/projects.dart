import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/project_filter.dart';
import 'package:student_hub/widgets/project_card.dart';
import 'package:student_hub/widgets/search_field.dart';
import 'package:dio/dio.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final List<Project> projects = [];
  List<Project> filteredProjects = [];
  final _debouncer = Debouncer(milliseconds: 500);
  final searchController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];
  Future<void> fetchProject() async {
    final dio = Dio();
    final response = await dio.get(
      '$apiServer/project',
    );
    final listResponse = response.data['result'];
    final List<Project> fetchProjects = listResponse
        .cast<Map<String, dynamic>>()
        .where((projectData) => projectData['deletedAt'] == null)
        .map<Project>((projectData) {
      return Project(
        id: projectData['id'],
        createdAt: DateTime.parse(projectData['createdAt']),
        deletedAt: projectData['deletedAt'] != null
            ? DateTime.parse(projectData['deletedAt'])
            : null,
        title: projectData['title'],
        completionTime: ProjectScopeFlag.oneToThreeMonth,
        requiredStudents: projectData['numberOfStudents'] ?? 0,
        description: projectData['description'],
        proposals: [],
        favorite: false,
      );
    }).toList();
    setState(() {
      projects.addAll(fetchProjects);
      filteredProjects = projects;
    });
  }

  void filterProjects(String query) {
    _debouncer.run(() => setState(() {
          filteredProjects = projects
              .where((project) =>
                  project.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }));
  }

  // String _selectedMenu = '';
  @override
  void initState() {
    super.initState();
    fetchProject();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    // final token = userProvider.currentUser?.token;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(30),
              Row(
                children: [
                  Expanded(
                    child: SearchBox(
                      controller: searchController,
                      onChanged: filterProjects,
                    ),
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
                          Navigator.pushNamed(
                              context, StudentRoutes.projectsSaved);
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
                                  child: const ProjectFilter(),
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
              projects.isEmpty
                  ? Column(
                      children: [
                        const Gap(50),
                        Text(
                          "There's no projects available",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Customize the color as per your preference
                          ),
                          textAlign: TextAlign
                              .center, // Align text center horizontally
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredProjects.length,
                        itemBuilder: (context, index) {
                          return ProjectCard(project: filteredProjects[index]);
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

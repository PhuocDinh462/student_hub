// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/api.services.dart';
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
  List<Project> projects = [];
  List<Project> filteredProjects = [];
  final _debouncer = Debouncer(milliseconds: 500);
  final searchController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];
  final ProjectService projectService = ProjectService();
  final dio = Dio();

  Future<void> fetchProject(UserProvider userProvider) async {
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer ${userProvider.currentUser?.token}',
    };
    final response = await dio.get(
      '$apiServer/project',
      options: Options(headers: headers),
    );
    final listResponse = response.data['result'];
    final List<Project> fetchProjects = listResponse
        .cast<Map<String, dynamic>>()
        .where((projectData) => projectData['deletedAt'] == null)
        .map<Project>((projectData) {
      return Project.fromMapInProjectsList(projectData);
    }).toList();
    setState(() {
      projects.clear();
      projects.addAll(fetchProjects);
      filteredProjects = projects;
    });
  }

  Future<void> resetProjects() async {
    setState(() {
      searchController.clear();
      filteredProjects = [];
      projects = [];
    });
  }

  Future<void> updateFilteredProjects(int? studentsNeeded, int? proposalsCount,
      int? projectScopeFlag, UserProvider provider) async {
    await resetProjects();
    context.loaderOverlay.show();
    try {
      final queries = {
        if (studentsNeeded != null &&
            studentsNeeded != 0 &&
            studentsNeeded.isNaN == false)
          'numberOfStudents': studentsNeeded,
        if (proposalsCount != null &&
            proposalsCount != 0 &&
            proposalsCount.isNaN == false)
          'proposalsLessThan': proposalsCount,
        if ((projectScopeFlag != -1 && projectScopeFlag?.isNaN == false) ||
            (projectScopeFlag == 0))
          'projectScopeFlag': projectScopeFlag,
      };
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer ${provider.currentUser?.token}',
      };
      final response = await dio.get(
        '$apiServer/project',
        queryParameters: queries,
        options: Options(headers: headers),
      );
      final listResponse = response.data['result'];
      List<Project> fetchProjects = listResponse
          .cast<Map<String, dynamic>>()
          .where((projectData) => projectData['deletedAt'] == null)
          .map<Project>((projectData) {
        return Project.fromMapInProjectsList(projectData);
      }).toList();
      setState(() {
        filteredProjects = fetchProjects;
        projects = fetchProjects;
      });
    } catch (e) {
      print(e);
    }
    context.loaderOverlay.hide();
  }

  void filterProjects(String query) {
    _debouncer.run(() => setState(() {
          filteredProjects = projects
              .where((project) =>
                  project.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }));
  }

  Future<void> _fetchData(UserProvider userProvider) async {
    context.loaderOverlay.show();
    await fetchProject(userProvider);
    context.loaderOverlay.hide();
  }

  // String _selectedMenu = '';
  @override
  void initState() {
    super.initState();
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    _fetchData(userProvider);
  }

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
                                  child: ProjectFilter(
                                      apiServer: apiServer,
                                      onFilterApplied: updateFilteredProjects),
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
              filteredProjects.isEmpty
                  ? Column(
                      children: [
                        const Gap(50),
                        Text(
                          "There's no projects available",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredProjects.length,
                        itemBuilder: (context, index) {
                          return ProjectCard(
                            project: filteredProjects[index],
                            projectService: projectService,
                          );
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

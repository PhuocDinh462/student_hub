import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/user.provider.dart';
import 'package:student_hub/widgets/project_card.dart';

class ProjectsSaved extends StatefulWidget {
  const ProjectsSaved({super.key});
  @override
  State<ProjectsSaved> createState() => _ProjectsSavedState();
}

class _ProjectsSavedState extends State<ProjectsSaved> {
  final List<Project> projects = [];
  final searchController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];
  final ProjectService projectService = ProjectService();
  bool isLoading = false;

  Future<void> fetchFavoriteProject(UserProvider userProvider) async {
    setState(() {
      projects.clear();
      isLoading = true;
    });

    try {
      final listResponse = await projectService
          .getFavoriteProjects(userProvider.currentUser!.studentId!);
      final List<Project> fetchProjects = listResponse
          .cast<Map<String, dynamic>>()
          .where((projectData) => projectData['deletedAt'] == null)
          .map<Project>((projectData) {
        return Project.fromMapInProjectsSavedList(projectData['project']);
      }).toList();
      setState(() {
        projects.addAll(fetchProjects);
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    fetchFavoriteProject(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(30),
              if (isLoading)
                const Column(
                  children: [
                    Gap(50),
                    CircularProgressIndicator(),
                  ],
                )
              else if (projects.isEmpty)
                Column(
                  children: [
                    const Gap(50),
                    Text(
                      "There's no saved projects available",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(
                          project: projects[index],
                          projectService: projectService);
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

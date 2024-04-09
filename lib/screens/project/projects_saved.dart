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
  Future<void> fetchProject(UserProvider userProvider) async {
    final listResponse = await projectService
        .getFavoriteProjects(userProvider.currentUser!.studentId!);
    final List<Project> fetchProjects = listResponse
        .cast<Map<String, dynamic>>()
        .where((projectData) => projectData['deletedAt'] == null)
        .map<Project>((projectData) {
      return Project(
        id: projectData['projectId'],
        createdAt: DateTime.parse(projectData['createdAt']),
        deletedAt: projectData['deletedAt'] != null
            ? DateTime.parse(projectData['deletedAt'])
            : null,
        title: projectData['title'],
        completionTime:
            ProjectScopeFlag.values[projectData['projectScopeFlag']],
        requiredStudents: projectData['numberOfStudents'] ?? 0,
        description: projectData['description'],
        proposals: projectData['countProposals'] ?? 0,
        favorite: projectData['isFavorite'] ?? false,
      );
    }).toList();
    setState(() {
      projects.addAll(fetchProjects);
    });
  }

  // String _selectedMenu = '';
  @override
  void initState() {
    super.initState();
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    fetchProject(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(30),
              projects.isEmpty
                  ? Column(
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
                  : Expanded(
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

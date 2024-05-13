import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/user.provider.dart';
import 'package:student_hub/utils/empty.dart';
import 'package:student_hub/widgets/project_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      throw Exception(e);
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
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : projects.isEmpty
              ? Center(
                  child:
                      Empty(text: AppLocalizations.of(context)!.noSavedProject))
              : ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(
                        project: projects[index],
                        projectService: projectService);
                  },
                ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/utils/snack_bar.dart';
import 'package:student_hub/widgets/project_detail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final ProjectService projectService;
  const ProjectCard(
      {super.key, required this.project, required this.projectService});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  late int daysAgo;
  late String timeDuration;
  late int studentsNeeded;
  late String projectDescription;
  late int proposalsCount;
  late bool isFavorite;
  final Dio dio = Dio();
  final String? apiServer = dotenv.env['API_SERVER'];

  @override
  void initState() {
    super.initState();
    initializeStateProject();
  }

  void initializeStateProject() {
    final project = widget.project;
    daysAgo = DateTime.now().difference(project.createdAt).inDays > 0
        ? DateTime.now().difference(project.createdAt).inDays
        : 1;
    timeDuration = project.completionTime == ProjectScopeFlag.lessThanOneMonth
        ? 'Less than 1 month'
        : project.completionTime == ProjectScopeFlag.oneToThreeMonth
            ? '1-3 months'
            : project.completionTime == ProjectScopeFlag.threeToSixMonth
                ? '3-6 months'
                : 'More than 6 months';

    studentsNeeded = project.requiredStudents;
    projectDescription = project.description;
    proposalsCount = project.countProposals;
    isFavorite = project.favorite;
  }

  Future<void> updateProjectState(
      UserProvider provider, int projectId, int disableFlag) async {
    try {
      if (disableFlag == 0) {
        setState(() {
          isFavorite = true;
        });
      }
      // Map<String, dynamic> headers = {
      //   'Authorization': 'Bearer ${provider.currentUser?.token}',
      // };
      // final data = {
      //   'projectId': projectId,
      //   'disableFlag': disableFlag,
      // };
      // await dio.patch(
      //   '$apiServer/favoriteProject/${provider.currentUser!.studentId!}',
      //   data: data,
      //   options: Options(headers: headers),
      // );
      await widget.projectService.updateFavoriteProject(
          provider.currentUser!.studentId!, projectId, disableFlag);
    } catch (e) {
      MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.createStudentProfile,
          AppLocalizations.of(context)!.errorOccuredContent,
          ContentType.failure);
      setState(() {
        isFavorite = false;
      });
      throw Exception(
          AppLocalizations.of(context)!.failedUpdateFavoriteProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.created} $daysAgo ${AppLocalizations.of(context)!.daysAgo}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.project.title,
                  style: const TextStyle(
                    color: primary_300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.time,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        '${timeDuration == 'Less than 1 month' ? AppLocalizations.of(context)!.lessThanOneMonth : timeDuration == '1-3 months' ? AppLocalizations.of(context)!.oneToThreeMonths : timeDuration == '3-6 months' ? AppLocalizations.of(context)!.threeToSixMonths : AppLocalizations.of(context)!.moreThanSixMonths}, $studentsNeeded ${AppLocalizations.of(context)!.studentsNeeded}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)!.studentLookingFor,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: projectDescription
                      .split('.')
                      .where((sentence) =>
                          sentence.trim().length >
                          1) // Lọc các câu có độ dài lớn hơn 1
                      .map((formattedSentence) => Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Text(
                              '• ${formattedSentence.trim()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ))
                      .toList(),
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.proposals,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$proposalsCount',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  isScrollControlled: true,
                  builder: (ctx) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ProjectDetails(
                        project: widget.project,
                        updateProjectState: updateProjectState,
                      ),
                    );
                  });
            },
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              iconSize: 28,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  updateProjectState(
                    userProvider,
                    widget.project.id,
                    isFavorite ? 0 : 1,
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

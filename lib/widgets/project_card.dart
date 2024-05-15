// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/project_detail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final ProjectService projectService;
  final BuildContext rootContext;
  const ProjectCard({
    super.key,
    required this.project,
    required this.projectService,
    required this.rootContext,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  late String daysAgo;
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
    daysAgo = Helpers.calculateTimeFromNow(
        widget.project.createdAt.toIso8601String(), widget.rootContext);
    timeDuration = widget.project.completionTime ==
            ProjectScopeFlag.lessThanOneMonth
        ? 'Less than 1 month'
        : widget.project.completionTime == ProjectScopeFlag.oneToThreeMonth
            ? '1-3 months'
            : widget.project.completionTime == ProjectScopeFlag.threeToSixMonth
                ? '3-6 months'
                : 'More than 6 months';

    studentsNeeded = widget.project.requiredStudents;
    projectDescription = widget.project.description;
    proposalsCount = widget.project.countProposals;
    isFavorite = widget.project.favorite;
  }

  Future<void> updateProjectState(
      UserProvider provider, int projectId, int disableFlag) async {
    try {
      if (disableFlag == 0) {
        setState(() {
          isFavorite = true;
        });
      }

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
    final textTheme = Theme.of(context).textTheme;

    final pjDes = projectDescription.split('.');

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
                  widget.project.title,
                  style: const TextStyle(
                    color: primary_300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${AppLocalizations.of(context)!.created} $daysAgo',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: textTheme.labelSmall?.color!.withOpacity(0.7),
                      fontSize: 12),
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.time,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        '${timeDuration == 'Less than 1 month' ? AppLocalizations.of(context)!.lessThanOneMonth : timeDuration == '1-3 months' ? AppLocalizations.of(context)!.oneToThreeMonths : timeDuration == '3-6 months' ? AppLocalizations.of(context)!.threeToSixMonths : AppLocalizations.of(context)!.moreThanSixMonths}, $studentsNeeded ${AppLocalizations.of(context)!.studentsNeeded}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)!.studentLookingFor,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: pjDes.length > 1
                      ? pjDes
                          .where((sentence) =>
                              sentence.trim().length >
                              1) // Lọc các câu có độ dài lớn hơn 1
                          .map((formattedSentence) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 4),
                                child: Text(
                                  '• ${formattedSentence.trim()}',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ))
                          .toList()
                      : [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Text(
                              '• ${pjDes[0].trim()}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          )
                        ],
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.proposals,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$proposalsCount',
                      style: Theme.of(context).textTheme.labelSmall,
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

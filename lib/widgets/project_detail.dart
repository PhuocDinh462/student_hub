import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/circle_container.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProjectDetailsView {
  viewProposal,
  viewActiveProposal,
  viewProjectProposal,
  viewOffer
}

class ProjectDetails extends StatefulWidget {
  const ProjectDetails(
      {super.key,
      required this.project,
      this.updateProjectState,
      this.viewType,
      this.acceptOffer});

  final Future<void> Function(UserProvider, int, int)? updateProjectState;
  final void Function()? acceptOffer;
  final Project project;
  final ProjectDetailsView? viewType;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late int daysAgo;
  late String timeDuration;
  late int studentsNeeded;
  late String projectDescription;
  late int proposalsCount;
  late bool isFavorite;
  final dio = Dio();
  final String? apiServer = dotenv.env['API_SERVER'];

  @override
  void initState() {
    super.initState();
    updateProjectData();
  }

  void updateProjectData() {
    final project = widget.project;
    daysAgo = DateTime.now().difference(project.createdAt).inDays > 0
        ? DateTime.now().difference(project.createdAt).inDays
        : 1;
    studentsNeeded = project.requiredStudents;
    projectDescription = project.description;
    proposalsCount = project.countProposals;
    isFavorite = project.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity, // Chiếm toàn bộ chiều rộng của màn hình
        child: Column(
          children: [
            CircleContainer(
              color: primary_300.withOpacity(0.3),
              child: const Icon(Icons.info, color: primary_300),
            ),
            const Gap(4),
            Column(
              children: [
                Text(
                  widget.project.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Gap(16),
            const Divider(thickness: 1.5, color: primary_300),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.studentLookingFor,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: projectDescription
                      .split('.')
                      .where((sentence) => sentence.trim().length > 1)
                      .map((formattedSentence) => Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8),
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
              ),
            ),
            const Divider(thickness: 1.5, color: primary_300),
            const Gap(16),
            Row(
              children: [
                const Icon(Icons.lock_clock, size: 40, color: primary_300),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.projectScope,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.project.completionTime2String(context),
                        style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                const Icon(Icons.people, size: 40, color: primary_300),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.studentRequire,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$studentsNeeded ${AppLocalizations.of(context)!.student}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(50),
            if (widget.viewType == ProjectDetailsView.viewOffer)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    onTap: () {
                      Get.back();
                    },
                    text: 'Back',
                    colorButton: primary_300,
                    colorText: text_50,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  if (widget.acceptOffer != null)
                    Button(
                      onTap: () {
                        widget.acceptOffer!();
                      },
                      text: 'Accept',
                      colorButton: primary_300,
                      colorText: text_50,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                ],
              )
            else if (widget.viewType != ProjectDetailsView.viewActiveProposal)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    onTap: () {
                      Get.toNamed(StudentRoutes.submitProposalStudent,
                          arguments: {'projectId': widget.project.id});
                    },
                    text: widget.viewType != ProjectDetailsView.viewProposal
                        ? AppLocalizations.of(context)!.applyNow
                        : AppLocalizations.of(context)!.viewLetter,
                    colorButton: Theme.of(context).colorScheme.tertiary,
                    colorText: Theme.of(context).colorScheme.onPrimary,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  if (widget.viewType != ProjectDetailsView.viewProposal &&
                      widget.viewType != ProjectDetailsView.viewActiveProposal)
                    Button(
                      onTap: () async {
                        await widget.updateProjectState!(
                            userProvider, widget.project.id, 0);
                        Get.back();
                      },
                      text: AppLocalizations.of(context)!.save,
                      colorButton: Theme.of(context).colorScheme.tertiary,
                      colorText: Theme.of(context).colorScheme.onPrimary,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

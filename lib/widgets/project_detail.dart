import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/circle_container.dart';
import 'package:gap/gap.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key, required this.project});
  final Project project;

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
    timeDuration = project.completionTime == ProjectScopeFlag.oneToThreeMonth
        ? '1-3 months'
        : '3-6 months';
    studentsNeeded = project.requiredStudents;
    projectDescription = project.description;
    proposalsCount = project.countProposals;
    isFavorite = project.favorite;
  }

  @override
  Widget build(BuildContext context) {
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
                const Gap(10),
                Text(
                  widget.project.title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const Gap(16),
            const Divider(thickness: 1.5, color: primary_300),
            Row(
              children: [
                Text(
                  'Student are looking for:',
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
                      'Project Scope',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(timeDuration,
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
                      'Student required',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$studentsNeeded students',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Apply Now',
                  colorButton: primary_300,
                  colorText: text_50,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Button(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Saved',
                  colorButton: primary_300,
                  colorText: text_50,
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

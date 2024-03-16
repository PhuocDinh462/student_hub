import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/widgets/project_detail.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

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
    timeDuration = project.completionTime;
    studentsNeeded = project.requiredStudents;
    projectDescription = project.description;
    proposalsCount = project.proposals.length;
    isFavorite = project.favorite;
  }

  @override
  Widget build(BuildContext context) {
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
                  'Created $daysAgo days ago',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.project.name,
                  style: const TextStyle(
                    color: primary_300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        '$timeDuration, $studentsNeeded students needed',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Student are looking for:',
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
                      'Proposals: ',
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
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  builder: (ctx) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ProjectDetails(project: widget.project),
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
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

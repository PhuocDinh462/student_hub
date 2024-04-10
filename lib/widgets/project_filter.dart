// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/project_length_options.dart';
import 'package:student_hub/widgets/text_field_title.dart';

class ProjectFilter extends StatefulWidget {
  final String? apiServer;

  final Future<void> Function(int?, int?, int?, UserProvider) onFilterApplied;
  const ProjectFilter(
      {super.key, required this.apiServer, required this.onFilterApplied});

  @override
  State<ProjectFilter> createState() => _ProjectFilterState();
}

class _ProjectFilterState extends State<ProjectFilter> {
  final studentsController = TextEditingController();
  final proposalsController = TextEditingController();
  late int _selectedProjectScope = 0;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Future<void> filterProjects() async {
      final studentsNeeded = int.tryParse(studentsController.text);
      final proposalsCount = int.tryParse(proposalsController.text);
      final projectScopeFlag = _selectedProjectScope - 1;
      widget.onFilterApplied(
          studentsNeeded, proposalsCount, projectScopeFlag, userProvider);
    }

    Future<void> clearFilter() async {
      widget.onFilterApplied(null, null, null, userProvider);
    }

    return Scaffold(
      backgroundColor: Colors.transparent, // Đặt màu nền trong suốt
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.cancel_rounded,
                    color: Colors.red,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Đóng widget ProjectFilter khi nhấn icon exit
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 1.5,
              color: primary_300,
            ),
            const Gap(8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Project Length',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    ProjectLengthOptions(
                      options: const [
                        'All',
                        'Less than one month',
                        '1 to 3 months',
                        '3 to 6 months',
                        'More than 6 months',
                      ],
                      onOptionSelected: (selectedOption) {
                        setState(() {
                          _selectedProjectScope = selectedOption;
                        });
                      },
                    ),
                    const Gap(20),
                    TextFieldTitle(
                      title: 'Students Needed',
                      hintText: 'Enter Number of Students',
                      controller: studentsController,
                    ),
                    const Gap(16),
                    TextFieldTitle(
                      title: 'Proposals less than',
                      hintText: 'Enter Number of Proposals',
                      controller: proposalsController,
                    ),
                    const Gap(50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          onTap: () async {
                            await clearFilter();
                            Navigator.pop(context);
                          },
                          text: 'Clear filters',
                          colorButton: primary_300,
                          colorText: text_50,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Button(
                          onTap: () async {
                            await filterProjects();
                            Navigator.pop(context);
                          },
                          text: 'Apply',
                          colorButton: primary_300,
                          colorText: text_50,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

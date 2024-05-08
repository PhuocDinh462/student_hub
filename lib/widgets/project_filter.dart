// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/project_length_options.dart';
import 'package:student_hub/widgets/text_field_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    color: color_1,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Đóng widget ProjectFilter khi nhấn icon exit
                  },
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Theme.of(context).primaryColorDark,
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
                          AppLocalizations.of(context)!.projectLength,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    ProjectLengthOptions(
                      options: [
                        AppLocalizations.of(context)!.all,
                        AppLocalizations.of(context)!.lessThanOneMonth,
                        AppLocalizations.of(context)!.oneToThreeMonths,
                        AppLocalizations.of(context)!.threeToSixMonths,
                        AppLocalizations.of(context)!.moreThanSixMonths,
                      ],
                      onOptionSelected: (selectedOption) {
                        setState(() {
                          _selectedProjectScope = selectedOption;
                        });
                      },
                    ),
                    const Gap(20),
                    TextFieldTitle(
                      title: AppLocalizations.of(context)!.studentsNeeded,
                      hintText: AppLocalizations.of(context)!.numberOfStudents,
                      controller: studentsController,
                      isNumber: true,
                    ),
                    const Gap(16),
                    TextFieldTitle(
                      title: AppLocalizations.of(context)!.proposalsLess,
                      hintText: AppLocalizations.of(context)!.numberOfProposals,
                      controller: proposalsController,
                      isNumber: true,
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
                          text: AppLocalizations.of(context)!.clearFilters,
                          colorButton: Theme.of(context).colorScheme.tertiary,
                          colorText: Theme.of(context).colorScheme.onPrimary,
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Button(
                          onTap: () async {
                            await filterProjects();
                            Navigator.pop(context);
                          },
                          text: AppLocalizations.of(context)!.apply,
                          colorButton: Theme.of(context).colorScheme.tertiary,
                          colorText: Theme.of(context).colorScheme.onPrimary,
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

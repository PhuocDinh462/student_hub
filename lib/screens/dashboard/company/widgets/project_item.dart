import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/screens/dashboard/company/widgets/bottom_tool_menu.dart';

class ProjectItem extends StatelessWidget {
  ProjectItem({super.key, required this.project});
  final Project project;

  final f = DateFormat('dd/MM/yyyy hh:mm');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return GestureDetector(
      onTap: () {
        projectProvider.setCurrentProject = project;
        Navigator.pushNamed(context, CompanyRoutes.projectDetail);
      },
      child: Card(
        child: Stack(
          children: [
            if (project.typeFlag == TypeFlag.archived)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: project.statusFlag == ProjectStatusFlag.fail
                      ? Icon(Icons.close_rounded,
                          color: Colors.red.withOpacity(.1), size: 150)
                      : Icon(Icons.check_rounded,
                          color: Colors.green.withOpacity(.1), size: 150),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 5, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(10),
                            Text(
                              project.title,
                              style: theme.textTheme.titleLarge
                                  ?.copyWith(color: primary_300),
                            ),
                            const Gap(3),
                            Text(
                              f.format(project.createdAt),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 32,
                          ),
                          onPressed: () {
                            projectProvider.setCurrentProject = project;
                            showModalBottomSheet<void>(
                              context: context,
                              backgroundColor: theme.colorScheme.onPrimary,
                              builder: (_) =>
                                  BottomToolMenu(rootContext: context),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Text(project.description),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(project.countProposals.toString(),
                              style: theme.textTheme.headlineLarge),
                          const Gap(10),
                          Icon(Icons.description,
                              color: theme.colorScheme.primary, size: 24),
                        ],
                      ),
                      Row(
                        children: [
                          Text(project.countMessages.toString(),
                              style: theme.textTheme.headlineLarge),
                          const Gap(10),
                          Icon(Icons.message_outlined,
                              color: theme.colorScheme.primary, size: 24),
                        ],
                      ),
                      Row(
                        children: [
                          Text(project.countHired.toString(),
                              style: theme.textTheme.headlineLarge),
                          const Gap(10),
                          Icon(Icons.check_circle,
                              color: theme.colorScheme.primary, size: 24),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

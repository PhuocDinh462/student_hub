import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/project.company.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/routes/company_route.dart';

class BottomToolMenu extends StatelessWidget {
  const BottomToolMenu({super.key});
  final double itemHeight = 50;
  final double dividerHeight = 30;

  @override
  Widget build(BuildContext context) {
    final ProjectService projectService = ProjectService();
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);
    final int itemCount =
        projectProvider.getCurrentProject!.typeFlag == TypeFlag.archieved
            ? 3
            : 4;

    void removeProject() async {
      context.loaderOverlay.show();
      await projectService
          .removeProject(projectProvider.getCurrentProject!.id)
          .then((value) {
        projectProvider.removeProject(projectProvider.getCurrentProject!);
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        context.loaderOverlay.hide();
        Navigator.pop(context);
      });
    }

    void updateProjectTypeFlag(TypeFlag typeFlag) async {
      context.loaderOverlay.show();
      await projectService.editProject(projectProvider.getCurrentProject!.id, {
        'title': projectProvider.getCurrentProject!.title,
        'typeFlag': typeFlag.index,
        'numberOfStudents': projectProvider.getCurrentProject!.requiredStudents,
      }).then((value) {
        projectProvider.editProject(value);
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        context.loaderOverlay.hide();
        Navigator.pop(context);
      });
    }

    return Container(
      height: itemCount * itemHeight + (itemCount - 1) * dividerHeight,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // View
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CompanyRoutes.projectDetail);
            },
            child: Container(
              color: Colors.transparent,
              height: itemHeight,
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'View',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'View project posting',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(height: dividerHeight, thickness: .5, color: text_600),

          // Edit
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              projectProvider.selectCurrentProject();
              Navigator.pushNamed(context, CompanyRoutes.editProject);
            },
            child: Container(
              color: Colors.transparent,
              height: itemHeight,
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'Edit posting',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(height: dividerHeight, thickness: .5, color: text_600),

          // Remove
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmation'),
                  content: const Text(
                      'Are you sure you want to remove this posting?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        removeProject();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            ),
            child: Container(
              color: Colors.transparent,
              height: itemHeight,
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remove',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'Remove posting',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          if (projectProvider.getCurrentProject!.typeFlag != TypeFlag.archieved)
            // Start
            Column(
              children: [
                Divider(height: dividerHeight, thickness: .5, color: text_600),
                projectProvider.getCurrentProject!.typeFlag == TypeFlag.newType
                    ? GestureDetector(
                        onTap: () => updateProjectTypeFlag(TypeFlag.working),
                        child: Container(
                          color: Colors.transparent,
                          height: itemHeight,
                          child: Row(
                            children: [
                              Icon(
                                Icons.start_outlined,
                                size: 32,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Gap(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Gap(3),
                                  Text(
                                    'Start working this project',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )

                    // Closed
                    : GestureDetector(
                        onTap: () => updateProjectTypeFlag(TypeFlag.archieved),
                        child: Container(
                          color: Colors.transparent,
                          height: itemHeight,
                          child: Row(
                            children: [
                              Icon(
                                Icons.close_rounded,
                                size: 32,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Gap(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Close',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Gap(3),
                                  Text(
                                    'Close this project',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
        ],
      ),
    );
  }
}

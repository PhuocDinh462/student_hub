import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/project.company.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/widgets/yes_no_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomToolMenu extends StatelessWidget {
  const BottomToolMenu({super.key, required this.rootContext});
  final double itemHeight = 50;
  final double dividerHeight = 30;
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    final ProjectService projectService = ProjectService();
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);
    final int itemCount =
        projectProvider.getCurrentProject!.typeFlag == TypeFlag.archived
            ? 3
            : 4;

    void removeProject() async {
      rootContext.loaderOverlay.show();
      await projectService
          .removeProject(projectProvider.getCurrentProject!.id)
          .then((value) {
        projectProvider.removeProject(projectProvider.getCurrentProject!);
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        rootContext.loaderOverlay.hide();
      });
    }

    void updateProjectTypeFlag(TypeFlag typeFlag) async {
      rootContext.loaderOverlay.show();
      await projectService.editProject(projectProvider.getCurrentProject!.id, {
        'title': projectProvider.getCurrentProject!.title,
        'typeFlag': typeFlag.index,
        'numberOfStudents': projectProvider.getCurrentProject!.requiredStudents,
      }).then((value) {
        projectProvider.editProject(value);
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        rootContext.loaderOverlay.hide();
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
                        AppLocalizations.of(context)!.view,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        AppLocalizations.of(context)!.viewProject,
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
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        AppLocalizations.of(context)!.editProject,
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
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return YesNoDialog(
                    title: AppLocalizations.of(context)!.removeProjectTitle,
                    content: AppLocalizations.of(context)!.removeProjectContent,
                    onYesPressed: () => removeProject(),
                  );
                },
              );
            },
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
                        AppLocalizations.of(context)!.remove,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        AppLocalizations.of(context)!.removeProjectTitle,
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

          if (projectProvider.getCurrentProject!.typeFlag != TypeFlag.archived)
            // Start
            Column(
              children: [
                Divider(height: dividerHeight, thickness: .5, color: text_600),
                projectProvider.getCurrentProject!.typeFlag == TypeFlag.newType
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return YesNoDialog(
                                title: AppLocalizations.of(context)!
                                    .startProjectTitle,
                                content: AppLocalizations.of(context)!
                                    .startProjectContent,
                                onYesPressed: () {
                                  if (projectProvider
                                          .getCurrentProject!.countHired <
                                      projectProvider.getCurrentProject!
                                          .requiredStudents) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .startProjectErrorNotEnoughStudent,
                                          style:
                                              const TextStyle(color: text_50),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    updateProjectTypeFlag(TypeFlag.working);
                                  }
                                },
                              );
                            },
                          );
                        },
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
                                    AppLocalizations.of(context)!.start,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Gap(3),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .startWorkingThisProject,
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
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return YesNoDialog(
                                title: AppLocalizations.of(context)!
                                    .closeProjectTitle,
                                content: AppLocalizations.of(context)!
                                    .closeProjectContent,
                                onYesPressed: () =>
                                    updateProjectTypeFlag(TypeFlag.archived),
                              );
                            },
                          );
                        },
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
                                    AppLocalizations.of(context)!.close,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Gap(3),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .closeThisProject,
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

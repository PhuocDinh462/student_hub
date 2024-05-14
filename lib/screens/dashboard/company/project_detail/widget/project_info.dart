import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          const Gap(30),
          // Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.create,
                size: 32,
                color: primary_200,
              ),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Gap(5),
                  SizedBox(
                    width: context.deviceSize.width - 100,
                    child: Text(
                      projectProvider.getCurrentProject!.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          // Description
          const Divider(
            height: 50,
            thickness: .5,
            color: text_700,
          ),
          const Gap(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.description,
                size: 32,
                color: primary_200,
              ),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Gap(5),
                  SizedBox(
                    width: context.deviceSize.width - 100,
                    child: Text(
                      projectProvider.getCurrentProject!.description,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          // Project scope
          const Divider(
            height: 50,
            thickness: .5,
            color: text_700,
          ),
          const Gap(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.access_time,
                size: 32,
                color: primary_200,
              ),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.projectScope,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Gap(5),
                  Text(
                    projectProvider.getCurrentProject!
                        .completionTime2String(context),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
          // Student required
          const Gap(10),
          const Divider(
            height: 50,
            thickness: .5,
            color: text_700,
          ),
          const Gap(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.people_alt,
                size: 32,
                color: primary_200,
              ),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.studentRequire,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Gap(5),
                  RichText(
                    textDirection: TextDirection.ltr,
                    text: TextSpan(children: [
                      TextSpan(
                        text:
                            '${projectProvider.getCurrentProject!.countHired}/${projectProvider.getCurrentProject!.requiredStudents}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: projectProvider
                                          .getCurrentProject!.countHired <
                                      projectProvider
                                          .getCurrentProject!.requiredStudents
                                  ? Colors.red
                                  : Colors.green,
                            ),
                      ),
                      TextSpan(
                          text: ' ${AppLocalizations.of(context)!.students}',
                          style: Theme.of(context).textTheme.titleLarge),
                    ]),
                  ),
                ],
              ),
            ],
          ),
          const Gap(40),
        ],
      ),
    );
  }
}

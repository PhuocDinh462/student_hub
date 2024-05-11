import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/project.company.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step4 extends StatelessWidget {
  Step4({super.key, required this.back});
  final VoidCallback back;
  final ProjectService projectService = ProjectService();

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    void postProject() async {
      context.loaderOverlay.show();
      await projectService.postProject({
        'companyId': userProvider.currentUser!.companyId,
        'projectScopeFlag': projectProvider.getProjectScope.index,
        'title': projectProvider.getTitle,
        'description': projectProvider.getDescription,
        'typeFlag': TypeFlag.newType.index,
        'numberOfStudents': projectProvider.getNumOfStudents,
      }).then((value) {
        projectProvider.addProject(value);
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        context.loaderOverlay.hide();
        Navigator.of(context).pop();
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            '4/4\t\t\t\t\t${AppLocalizations.of(context)!.postProjectStep4Title}',
            style: Theme.of(context).textTheme.titleLarge),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                SizedBox(
                  width: context.deviceSize.width - 100,
                  child: Text(projectProvider.getTitle),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                SizedBox(
                  width: context.deviceSize.width - 100,
                  child: Text(projectProvider.getDescription),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                Text(
                  Project.projectScopeFlag2String(
                      context, projectProvider.getProjectScope),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
        // Project scope
        const Gap(40),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                Text(
                  '${projectProvider.getNumOfStudents.toString()} ${AppLocalizations.of(context)!.students}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
        const Gap(40),
        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () => back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? text_800
                          : text_300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.arrow_back, color: text_50)),
            const Gap(15),
            ElevatedButton(
                onPressed: () => postProject(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary_300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.check, color: text_50)),
          ],
        ),
      ],
    );
  }
}

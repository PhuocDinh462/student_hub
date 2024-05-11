import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/project.company.service.dart';
import 'package:student_hub/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/providers/project.provider.dart';

class CloseProjectDialog extends StatefulWidget {
  const CloseProjectDialog({super.key, required this.rootContext});
  final BuildContext rootContext;

  @override
  createState() => _CloseProjectDialogState();
}

class _CloseProjectDialogState extends State<CloseProjectDialog> {
  final ProjectService projectService = ProjectService();
  ProjectStatusFlag _statusFlag = ProjectStatusFlag.success;

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    void updateProjectTypeFlag() async {
      widget.rootContext.loaderOverlay.show();
      await projectService.editProject(projectProvider.getCurrentProject!.id, {
        'title': projectProvider.getCurrentProject!.title,
        'numberOfStudents': projectProvider.getCurrentProject!.requiredStudents,
        'typeFlag': TypeFlag.archived.index,
        'status': _statusFlag.index,
      }).then((value) {
        projectProvider.editProject(value);
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        widget.rootContext.loaderOverlay.hide();
      });
    }

    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.closeProjectTitle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.closeProjectContent),
          RadioListTile(
            title: Text(AppLocalizations.of(context)!.success),
            value: ProjectStatusFlag.success,
            groupValue: _statusFlag,
            onChanged: (value) => setState(
              () => _statusFlag = value!,
            ),
          ),
          RadioListTile(
            title: Text(AppLocalizations.of(context)!.fail),
            value: ProjectStatusFlag.fail,
            groupValue: _statusFlag,
            onChanged: (value) => setState(
              () => _statusFlag = value!,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.75),
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            updateProjectTypeFlag();
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.confirm,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExperienceItem extends StatelessWidget {
  const ExperienceItem(
      {super.key,
      required this.exp,
      required this.actionDelete,
      required this.actionEdit,
      this.appLocal});

  final ExperienceModel exp;
  final AppLocalizations? appLocal;
  final Function() actionDelete;
  final Function() actionEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    final String timeDuration =
        '${Helpers.formatMMYYYTToString(exp.startMonth)} - ${Helpers.formatMMYYYTToString(exp.endMonth)}, ${Helpers.calculateMonthsBetween(exp.startMonth, exp.endMonth)} months';
    final List<String> skills = exp.skillSets
        .map(
          (e) => e.name,
        )
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primary_200, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: deviceSize.width * 0.6,
                child: DisplayText(
                  text: exp.title,
                  style: textTheme.bodySmall!,
                  overflow: TextOverflow.visible,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    iconSize: 24,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      actionEdit();
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: primary_300,
                    ),
                  ),
                  IconButton(
                      iconSize: 25,
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        actionDelete();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: color_1,
                      )),
                ],
              )
            ],
          ),
          DisplayText(
              text: timeDuration,
              style: textTheme.labelSmall!.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8), fontSize: 12)),
          const Gap(10),
          DisplayText(
            text: exp.description,
            style: textTheme.bodySmall!,
            overflow: TextOverflow.visible,
          ),
          const Gap(10),
          DisplayText(text: appLocal!.skillset, style: textTheme.bodyLarge!),
          const Gap(5),
          ChipList(listChip: skills),
          const Gap(30)
        ],
      ),
    );
  }
}

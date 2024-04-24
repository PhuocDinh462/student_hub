import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/widgets/description_project.dart';
import 'package:student_hub/widgets/widgets.dart';

class CardInfoProposal extends StatelessWidget {
  const CardInfoProposal({super.key, required this.proposal});
  final ProposalModel proposal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DisplayText(
                text: proposal.project!.title,
                style: textTheme.titleMedium!.copyWith(color: primary_300)),
            DisplayText(
                text:
                    'Submitted ${Helpers.calculateTimeFromNow(proposal.updatedAt ?? '')} ',
                style: textTheme.labelSmall!.copyWith(
                    color: textTheme.labelSmall?.color!.withOpacity(0.7))),
            const Gap(15),
            DescriptionProject(
                projectDescription: proposal.project!.description,
                title: 'Students are looking for:'),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

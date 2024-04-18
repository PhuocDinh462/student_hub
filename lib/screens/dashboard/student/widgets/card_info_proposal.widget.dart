import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/description_project.dart';
import 'package:student_hub/widgets/widgets.dart';

class CardInfoProposal extends StatelessWidget {
  const CardInfoProposal({super.key});

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
                text: 'Senior frontend developer (Fintech)',
                style: textTheme.titleMedium!.copyWith(color: primary_300)),
            // const Gap(5),
            DisplayText(
                text: 'Submitted 3 days ago',
                style: textTheme.labelSmall!.copyWith(
                    color: textTheme.labelSmall?.color!.withOpacity(0.7))),
            const Gap(15),
            DescriptionProject(
                projectDescription:
                    'Clear expectation about your project.Clear expectation about your project.Clear expectation about your project.Clear expectation about your project.Clear expectation about your project',
                title: 'Students are looking for:'),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

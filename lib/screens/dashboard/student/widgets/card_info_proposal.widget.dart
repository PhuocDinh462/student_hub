import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/widgets/description_project.dart';
import 'package:student_hub/widgets/widgets.dart';

class CardInfoProposal extends StatelessWidget {
  const CardInfoProposal(
      {super.key, required this.proposal, this.action, this.view});
  final ProposalModel proposal;
  final ProjectDetailsView? view;
  final Function(Project)? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    String timeDuration = proposal.project!.projectScopeFlag ==
            ProjectScopeFlag.lessThanOneMonth
        ? 'Less than 1 month'
        : proposal.project!.projectScopeFlag == ProjectScopeFlag.oneToThreeMonth
            ? '1-3 months'
            : proposal.project!.projectScopeFlag ==
                    ProjectScopeFlag.threeToSixMonth
                ? '3-6 months'
                : 'More than 6 months';

    int studentsNeeded = proposal.project!.numberOfStudents;

    return InkWell(
      onTap: () {
        Project p = Project(
          id: proposal.projectId,
          createdAt: DateTime.parse(proposal.project!.createdAt!),
          description: proposal.project!.description,
          title: proposal.project!.title,
          completionTime: proposal.project!.projectScopeFlag,
          requiredStudents: proposal.project!.numberOfStudents,
          proposals: proposal,
          favorite: false,
        );

        action!(p);
      },
      child: Card(
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
              if (view == ProjectDetailsView.viewProjectProposal)
                _buildDisplayText(
                    'Time $timeDuration, $studentsNeeded students',
                    textTheme,
                    colorScheme),
              if (view == ProjectDetailsView.viewProposal)
                _buildDisplayText(
                    'Submitted ${Helpers.calculateTimeFromNow(proposal.createdAt ?? '')}',
                    textTheme,
                    colorScheme),
              if (view == ProjectDetailsView.viewActiveProposal)
                _buildDisplayText(
                    'Actived ${Helpers.calculateTimeFromNow(proposal.updatedAt ?? '')}',
                    textTheme,
                    colorScheme),
              const Gap(15),
              DescriptionProject(
                  projectDescription: proposal.project!.description,
                  title: 'Students are looking for:'),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayText(
      String text, TextTheme textTheme, ColorScheme colorScheme) {
    return DisplayText(
      text: text,
      style: textTheme.labelSmall!.copyWith(
        color: textTheme.labelSmall?.color!.withOpacity(0.7),
      ),
    );
  }
}

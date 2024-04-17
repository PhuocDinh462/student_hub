import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/routes/company_route.dart';

class ProposalItem extends StatelessWidget {
  const ProposalItem({super.key, required this.proposal});
  final Proposal proposal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(CompanyRoutes.proposalDetail, arguments: proposal.id);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proposal.studentName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22),
                  ),
                  const Gap(5),
                  Text(
                    proposal.techStackName,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right_outlined, size: 32)
            ],
          ),
        ),
      ),
    );
  }
}

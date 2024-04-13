import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/proposal.dart';

class ProposalItem extends StatelessWidget {
  const ProposalItem({super.key, required this.proposal});
  final Proposal proposal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 100),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposal.studentName,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const Gap(5),
                    Text(
                      '4th year student',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.work,
                        color: Theme.of(context).colorScheme.primary),
                    const Gap(10),
                    Text(proposal.techStackName,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: Theme.of(context).colorScheme.primary),
                    const Gap(10),
                    Text('Excellent',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ],
            ),
            const Gap(20),
            Text(proposal.coverLetter),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: primary_300),
                  child: const SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.message_outlined, color: text_50, size: 20),
                        Gap(10),
                        Text('Message',
                            style: TextStyle(
                              color: text_50,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Hired offer',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          content: const Text(
                              'Do you really want to send hired offer for student to do this project?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Cancel hire action
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.75),
                                    ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Perform hire action
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Send',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primary_300),
                  child: const SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_box_outlined,
                            color: text_50, size: 20),
                        Gap(10),
                        Text('Hire',
                            style: TextStyle(
                              color: text_50,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Text('Senior frontend developer (Fintech)',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: primary_300)),
                const Gap(3),
                Text(
                  'Created 3 days ago',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.more,
                size: 32,
                color: primary_300,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const Gap(10),
        const Text(
            'Students are looking for\n - Clear expectation about your project or deliverables'),
        const Gap(30),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('8', style: Theme.of(context).textTheme.displayLarge),
                  const Gap(10),
                  const Row(
                    children: [
                      Icon(Icons.description, color: primary_300, size: 24),
                      Gap(5),
                      Text('Proposals'),
                    ],
                  ),
                ],
              ),
              const VerticalDivider(
                thickness: .5,
                color: text_400,
              ),
              Column(
                children: [
                  Text('8', style: Theme.of(context).textTheme.displayLarge),
                  const Gap(10),
                  const Row(
                    children: [
                      Icon(Icons.message_outlined,
                          color: primary_300, size: 24),
                      Gap(5),
                      Text('Messages'),
                    ],
                  ),
                ],
              ),
              const VerticalDivider(
                thickness: .5,
                color: text_400,
              ),
              Column(
                children: [
                  Text('8', style: Theme.of(context).textTheme.displayLarge),
                  const Gap(10),
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: primary_300, size: 24),
                      Gap(5),
                      Text('Hired'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/dashboard/widgets/bottom_tool_menu.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 5, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Text(
                        'Senior frontend developer (Fintech)',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: primary_300),
                      ),
                      const Gap(3),
                      Text(
                        'Created 3 days ago',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 32,
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        builder: (BuildContext context) {
                          return const BottomToolMenu();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Text(
                'Students are looking for\n - Clear expectation about your project or deliverables'),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('8', style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(10),
                    Icon(Icons.description,
                        color: Theme.of(context).colorScheme.primary, size: 24),
                  ],
                ),
                Row(
                  children: [
                    Text('8', style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(10),
                    Icon(Icons.message_outlined,
                        color: Theme.of(context).colorScheme.primary, size: 24),
                  ],
                ),
                Row(
                  children: [
                    Text('8', style: Theme.of(context).textTheme.headlineLarge),
                    const Gap(10),
                    Icon(Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary, size: 24),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

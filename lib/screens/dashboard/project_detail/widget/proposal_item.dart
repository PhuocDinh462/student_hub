import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/screens/dashboard/widgets/bottom_tool_menu.dart';

class ProposalItem extends StatelessWidget {
  const ProposalItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.person, size: 100),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Doe',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
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
                Icon(Icons.work, color: Theme.of(context).colorScheme.primary),
                const Gap(10),
                Text('Fullstack Engineer',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Row(
              children: [
                Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
                const Gap(10),
                Text('Excellent',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ],
        ),
        const Gap(20),
        const Text(
            'I have gone through your project and it seem like a great project. I will commit for your project...'),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {},
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
              onPressed: () {},
              child: const SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_box_outlined, color: text_50, size: 20),
                    Gap(10),
                    Text('Hired',
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
    );
  }
}

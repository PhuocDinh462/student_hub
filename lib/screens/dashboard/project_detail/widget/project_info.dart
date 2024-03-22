import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/extensions.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.create,
              size: 32,
              color: primary_200,
            ),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                SizedBox(
                  width: context.deviceSize.width - 100,
                  child: const Text('Senior frontend developer (Fintech)'),
                ),
              ],
            ),
          ],
        ),
        const Gap(10),
        // Description
        const Divider(
          height: 50,
          thickness: .5,
          color: text_700,
        ),
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.description,
              size: 32,
              color: primary_200,
            ),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                SizedBox(
                  width: context.deviceSize.width - 100,
                  child: const Text('Students are looking for\n'
                      '- Clear expectation about your project or deliverables\n'
                      '- The skills required for your project\n'
                      '- Detail about your project'),
                ),
              ],
            ),
          ],
        ),
        const Gap(10),
        // Project scope
        const Divider(
          height: 50,
          thickness: .5,
          color: text_700,
        ),
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.access_time,
              size: 32,
              color: primary_200,
            ),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project scope',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                const Text(
                  '1 to 3 months',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
        // Project scope
        const Gap(40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.people_alt,
              size: 32,
              color: primary_200,
            ),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student required',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(5),
                const Text(
                  '4 students',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
        const Gap(40),
      ],
    );
  }
}

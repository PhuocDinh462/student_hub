import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/chip_list.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({super.key});

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool isEdit = false;

  List<String> skills = [
    'Reactjs',
    'Nodejs',
    'Flutter',
    'Dart',
    'Python',
    'JavaScript',
    'C/C++'
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
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
                    text: 'Intelligent Taxi Dispatching system',
                    style: textTheme.bodySmall!),
              ),
              Row(
                children: [
                  IconButton(
                      iconSize: 23,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                      )),
                  IconButton(
                      iconSize: 25,
                      onPressed: () {},
                      color: color_1,
                      icon: const Icon(
                        Icons.delete,
                      ))
                ],
              )
            ],
          ),
          DisplayText(
              text: '9/2020 - 12/2020, 4 months', style: textTheme.labelSmall!),
          const Gap(10),
          DisplayText(
              text:
                  'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..',
              style: textTheme.bodySmall!),
          const Gap(10),
          DisplayText(text: 'Skillset', style: textTheme.bodyLarge!),
          const Gap(5),
          ChipList(listChip: skills),
          const Gap(30)
        ],
      ),
    );
  }
}

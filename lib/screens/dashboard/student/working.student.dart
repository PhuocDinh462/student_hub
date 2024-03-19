import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/widgets.dart';

class WorkingStudent extends StatelessWidget {
  const WorkingStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayText(
                      text: 'Senior frontend developer (Fintech)',
                      style: textTheme.labelMedium!),
                  const Gap(5),
                  DisplayText(
                      text: 'Submitted 3 days ago',
                      style: textTheme.labelSmall!),
                  const Gap(10),
                  DisplayText(
                      text: 'Students are looking for...',
                      style: textTheme.labelMedium!),
                  const Gap(20),
                  const Divider(
                    color: text_400,
                    height: 2,
                  ),
                  const Gap(30)
                ],
              ),
            );
          }),
    );
  }
}

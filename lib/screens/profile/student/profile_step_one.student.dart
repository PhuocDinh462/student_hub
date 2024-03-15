import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/display_text.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileStudentStepOne extends StatefulWidget {
  const ProfileStudentStepOne({super.key});

  @override
  State<ProfileStudentStepOne> createState() => _ProfileStudentStepOneState();
}

class _ProfileStudentStepOneState extends State<ProfileStudentStepOne> {
  String valueDrop = 'FullStack Engineer';

  List<String> lst = [
    'FullStack Engineer',
    'Frontend Engineer',
    'Backend Engineer',
    'Mobile Engineer',
    'DevOps Engineer',
    'Data Engineer',
    'Data Scientist',
    'Product Manager',
    'UX/UI Designer',
    'QA Engineer',
    'Security Engineer',
    'Network Engineer',
    'Cloud Engineer',
    'Game Developer',
    'Embedded Engineer',
    'AI/ML Engineer',
    'AR/VR Engineer',
    'Blockchain Engineer',
    'Robotics Engineer',
    'Other Engineer'
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DisplayText(
                    text: 'Welcome to Student Hub',
                    style: textTheme.headlineLarge!,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(10),
                  DisplayText(
                    text:
                        'Tell us about your self and you will be on your way connect with real-world projects.',
                    style: textTheme.bodySmall!,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(20),
                  CommonDropdownText(
                    listItem: lst,
                    title: 'Techstack',
                  )
                ]),
          ),
        )
      ],
    );
  }
}

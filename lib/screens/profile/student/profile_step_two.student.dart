import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/styles/button_style.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileStudentStepTwo extends StatefulWidget {
  const ProfileStudentStepTwo({super.key});

  @override
  State<ProfileStudentStepTwo> createState() => _ProfileStudentStepTwoState();
}

class _ProfileStudentStepTwoState extends State<ProfileStudentStepTwo> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DisplayText(
                          text: 'Projects', style: textTheme.bodyLarge!),
                      IconButton(
                          iconSize: 30,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                          ))
                    ]),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: deviceSize.width,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: colorScheme.onSurface.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, -3),
              ),
            ]),
            child: ElevatedButton(
                style: buttonPrimary,
                onPressed: () {},
                child: DisplayText(
                  text: 'Next',
                  style: textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/post_job/widgets/step1.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  final int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(15),
            StepProgressIndicator(
              totalSteps: 4,
              currentStep: _currentStep,
              selectedColor: primary_300,
              unselectedColor: primary_50,
            ),
            const Gap(15),
            const Step1(),
            const Gap(15),
          ],
        ),
      ),
    );
  }
}

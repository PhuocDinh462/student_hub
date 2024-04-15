import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/dashboard/company/edit_project/widgets/widgets.dart';

class EditProject extends StatefulWidget {
  const EditProject({super.key});

  @override
  createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  int _currentStep = 1;
  void next() => setState(() => _currentStep++);
  void back() => setState(() => _currentStep--);

  @override
  Widget build(BuildContext context) {
    Widget stepWidget;

    switch (_currentStep) {
      case 1:
        stepWidget = Step1(next: next);
        break;
      case 2:
        stepWidget = Step2(back: back, next: next);
        break;
      case 3:
        stepWidget = Step3(back: back, next: next);
        break;
      case 4:
        stepWidget = Step4(back: back);
        break;
      default:
        stepWidget = Step1(next: next);
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            StepProgressIndicator(
              totalSteps: 4,
              currentStep: _currentStep,
              roundedEdges: const Radius.circular(10),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Theme.of(context).brightness == Brightness.dark
                  ? text_800
                  : primary_50,
            ),
            const Gap(15),
            stepWidget,
            const Gap(15),
          ],
        ),
      ),
    );
  }
}

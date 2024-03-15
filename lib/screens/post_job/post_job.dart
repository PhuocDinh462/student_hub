import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/theme_provider.dart';
import 'package:student_hub/screens/post_job/widgets/widgets.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  int _currentStep = 1;
  void next() => setState(() => _currentStep++);
  void back() => setState(() => _currentStep--);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

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
              selectedColor: themeProvider.getThemeMode ? text_50 : primary_300,
              unselectedColor:
                  themeProvider.getThemeMode ? text_800 : primary_50,
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

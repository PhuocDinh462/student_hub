import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step2 extends StatelessWidget {
  Step2({
    super.key,
    required this.back,
    required this.next,
  });
  final _formKey = GlobalKey<FormState>();
  final VoidCallback back;
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              '2/4\t\t\t\t\t${AppLocalizations.of(context)!.postProjectStep2Title}',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Center(
            child: Image.asset(
              'assets/images/Coding-workshop.png',
              width: context.deviceSize.width / 1.5,
            ),
          ),
          const Gap(5),
          Text(AppLocalizations.of(context)!.postProjectStep2Scope,
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: ProjectScopeFlag.lessThanOneMonth,
                    groupValue: projectProvider.getProjectScope,
                    onChanged: (value) =>
                        projectProvider.setProjectScope = value!,
                  ),
                  Text(AppLocalizations.of(context)!.lessThanOneMonth),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: ProjectScopeFlag.oneToThreeMonth,
                    groupValue: projectProvider.getProjectScope,
                    onChanged: (value) =>
                        projectProvider.setProjectScope = value!,
                  ),
                  Text(AppLocalizations.of(context)!.oneToThreeMonths),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: ProjectScopeFlag.threeToSixMonth,
                    groupValue: projectProvider.getProjectScope,
                    onChanged: (value) =>
                        projectProvider.setProjectScope = value!,
                  ),
                  Text(AppLocalizations.of(context)!.threeToSixMonths),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: ProjectScopeFlag.moreThanSixMonth,
                    groupValue: projectProvider.getProjectScope,
                    onChanged: (value) =>
                        projectProvider.setProjectScope = value!,
                  ),
                  Text(AppLocalizations.of(context)!.moreThanSixMonths),
                ],
              ),
            ],
          ),
          const Gap(20),
          Text(AppLocalizations.of(context)!.postProjectStep2StudentRequire,
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => projectProvider.getNumOfStudents > 1
                      ? projectProvider.removeStudents()
                      : null,
                  icon: const Icon(Icons.remove)),
              const Gap(20),
              NumberPicker(
                value: projectProvider.getNumOfStudents,
                selectedTextStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primary_300,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
                minValue: 1,
                maxValue: 100,
                itemHeight: 60,
                itemWidth: 60,
                axis: Axis.horizontal,
                onChanged: (value) => projectProvider.setNumOfStudents = value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? text_300
                          : primary_300,
                      width: 2),
                ),
              ),
              const Gap(20),
              IconButton(
                  onPressed: () => projectProvider.getNumOfStudents < 100
                      ? projectProvider.addStudents()
                      : null,
                  icon: const Icon(Icons.add)),
            ],
          ),
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () => back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? text_800
                            : text_300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.arrow_back, color: text_50)),
              const Gap(15),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) next();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary_300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward, color: text_50)),
            ],
          ),
        ],
      ),
    );
  }
}

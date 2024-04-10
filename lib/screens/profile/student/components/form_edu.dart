import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/widgets/widgets.dart';

class FormEdu extends StatelessWidget {
  const FormEdu(
      {super.key,
      required this.controller,
      required this.actionCancel,
      required this.actionSave,
      required this.actionChangeStartYear,
      required this.actionChangeEndYear,
      required this.yearStart,
      required this.yearEnd});
  final TextEditingController controller;
  final DateTime yearStart;
  final DateTime yearEnd;
  final Function() actionCancel;
  final Function() actionSave;
  final Function(DateTime) actionChangeStartYear;
  final Function(DateTime) actionChangeEndYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonTextField(
            title: '',
            hintText: 'Enter education',
            controller: controller,
          ),
          const Gap(5),
          Row(
            children: [
              Expanded(
                  child: SelectYear(
                selectedYear: yearStart,
                title: 'Year Start',
                actionSelectYear: actionChangeStartYear,
              )),
              const Gap(10),
              Expanded(
                  child: SelectYear(
                selectedYear: yearEnd,
                title: 'Year End',
                actionSelectYear: actionChangeEndYear,
              ))
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Gap(15),
              ElevatedButton(
                  style: buttonSecondary,
                  onPressed: () => {actionCancel()},
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
              const Gap(15),
              ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () => {actionSave()},
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
            ],
          ),
          const Gap(5),
          const Divider(
            color: text_300,
            height: 2,
            thickness: 1,
          )
        ],
      ),
    );
  }
}

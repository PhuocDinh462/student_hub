import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:student_hub/widgets/text_field_title.dart';

class SelectYear extends StatelessWidget {
  const SelectYear(
      {super.key,
      required this.title,
      required this.selectedYear,
      required this.actionSelectYear});

  final String title;
  final DateTime selectedYear;
  final Function(DateTime) actionSelectYear;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldTitle(
            title: title,
            hintText: DateFormat.y().format(selectedYear),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => selectYear(context),
              icon: const Icon(Icons.calendar_month),
            ),
          ),
        ),
        const Gap(5),
      ],
    );
  }

  void selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Year'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              lastDate: DateTime.now(),
              selectedDate: selectedYear,
              onChanged: (DateTime dateTime) {
                actionSelectYear(dateTime);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

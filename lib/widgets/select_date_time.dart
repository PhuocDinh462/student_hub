import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/widgets/text_field_title.dart';

// ignore: must_be_immutable
class SelectDateTime extends StatefulWidget {
  SelectDateTime(
      {super.key,
      required this.titleDate,
      required this.titleTime,
      required this.date,
      required this.time});

  final String titleDate;
  final String titleTime;
  late DateTime date;
  late TimeOfDay time;

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  late DateTime _pickedDate;
  late TimeOfDay _pickedTime;

  @override
  void initState() {
    super.initState();
    _pickedDate = widget.date;
    _pickedTime = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldTitle(
            title: widget.titleDate,
            hintText: DateFormat.yMMMd().format(widget.date),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_month),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: TextFieldTitle(
            title: widget.titleTime,
            hintText: Helpers.timeToString(widget.time),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context),
              icon: const Icon(Icons.alarm),
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: text_900),
              // bodyMedium: TextStyle(color: Colors.blue),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        widget.date = pickedDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _pickedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: TextTheme(
              bodyLarge: const TextStyle(color: text_900),
              bodyMedium: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: primary_300,
                    fontWeight: FontWeight.bold,
                  ),
              bodySmall: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: primary_200,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            colorScheme: const ColorScheme.light(
                // background: Colors.white,
                // brightness: Brightness.light,
                ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        widget.time = pickedTime;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/widgets/text_field_title.dart';

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({super.key});

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  late DateTime _pickedDate;
  late TimeOfDay _pickedTime;

  @override
  void initState() {
    super.initState();
    _pickedDate = DateTime.now();
    _pickedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldTitle(
            title: 'Date',
            hintText: DateFormat.yMMMd().format(_pickedDate),
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
            title: 'Time',
            hintText: Helpers.timeToString(_pickedTime),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context),
              icon: const Icon(Icons.calendar_month),
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
    );
    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _pickedTime,
    );
    if (pickedTime != null) {
      setState(() {
        _pickedTime = pickedTime;
      });
    }
  }
}

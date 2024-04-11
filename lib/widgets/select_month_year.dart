import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:student_hub/widgets/text_field_title.dart';

class SelectMonthYear extends StatelessWidget {
  const SelectMonthYear({
    super.key,
    required this.pickedDate,
    required this.title,
    required this.actionSelect,
  });

  final DateTime pickedDate;
  final String title;
  final Function(DateTime) actionSelect;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldTitle(
            title: title,
            hintText: DateFormat.yM().format(pickedDate),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_month),
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    final pickedDateFunc = await showMonthYearPicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030),
        locale: const Locale('vi', 'VN'));

    if (pickedDateFunc != null) {
      actionSelect(pickedDateFunc);
    }
  }
}

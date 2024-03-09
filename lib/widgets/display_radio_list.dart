import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/widgets.dart';

class DisplayRadioList extends StatefulWidget {
  const DisplayRadioList({super.key});

  @override
  State<DisplayRadioList> createState() => _DisplayRadioListState();
}

List<String> options = [
  'It\'s just me',
  '2-9 employees',
  '10-99 employees',
  '100-1000 employees',
  'More than 1000 employees',
];

class _DisplayRadioListState extends State<DisplayRadioList> {
  int curOption = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemExtent: 40,
      itemBuilder: (ctx, index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                curOption = index;
              });
            },
            child: Row(
              children: [
                Radio(
                  value: index,
                  groupValue: curOption,
                  onChanged: (value) {
                    setState(() {
                      curOption = value!;
                    });
                  },
                ),
                DisplayText(
                  text: options[index],
                  color: text_900,
                  fontWeight: FontWeight.w400,
                  size: 16,
                )
              ],
            ));
      },
    );
  }
}

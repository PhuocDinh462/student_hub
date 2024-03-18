import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/widgets.dart';

class EducationItem extends StatefulWidget {
  const EducationItem({super.key});

  @override
  State<EducationItem> createState() => _EducationItemState();
}

class _EducationItemState extends State<EducationItem> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DisplayText(
                text: 'Le Hong Phong High School', style: textTheme.bodySmall!),
            Row(
              children: [
                IconButton(
                    iconSize: 23,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                    )),
                IconButton(
                    iconSize: 25,
                    onPressed: () {},
                    color: color_1,
                    icon: const Icon(
                      Icons.delete,
                    ))
              ],
            )
          ],
        ),
        DisplayText(text: '2008-2010', style: textTheme.labelSmall!)
      ],
    );
  }
}

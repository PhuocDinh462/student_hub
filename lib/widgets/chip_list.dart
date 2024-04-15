import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/widgets.dart';

class ChipList extends StatelessWidget {
  const ChipList({super.key, required this.listChip});
  final List<String> listChip;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 10,
      children: listChip
          .map(
            (e) => Chip(
              labelStyle: textTheme.labelLarge,
              deleteIconColor: color_1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: const BorderSide(color: primary_300, width: 1)),
              label: DisplayText(text: e, style: textTheme.labelSmall!),
              onDeleted: null,
            ),
          )
          .toList(),
    );
  }
}

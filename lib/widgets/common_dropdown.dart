import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/widgets.dart';

class CommonDropdown extends StatelessWidget {
  const CommonDropdown(
      {super.key,
      required this.listItem,
      required this.title,
      this.maxHeight = 300,
      required this.value,
      required this.onChange});
  final List<dynamic> listItem;
  final String title;
  final double maxHeight;
  final int value;
  final void Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DisplayText(text: title, style: textTheme.bodyLarge!),
      const Gap(5),
      SingleChildScrollView(
          child: DropdownButtonFormField<int>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down),
        style: textTheme.bodySmall!.copyWith(
            color: value == -1 ? text_400 : textTheme.bodySmall!.color),
        menuMaxHeight: maxHeight,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.onSurface),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.onSurface),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
        ),
        onChanged: (int? value) {
          onChange(value!);
        },
        items: listItem
            .map((e) => DropdownMenuItem<int>(
                  value: e.id,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayText(
                          text: e.name,
                          style: textTheme.bodySmall!.copyWith(
                              color: e.id == -1
                                  ? text_400
                                  : textTheme.bodySmall!.color),
                        ),
                        const Gap(10),
                        const Divider(
                          color: text_300,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ))
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/widgets.dart';

class CommonDropdownText extends StatelessWidget {
  const CommonDropdownText(
      {super.key,
      required this.listItem,
      required this.title,
      this.maxHeight = 300});
  final List<String> listItem;
  final String title;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    int value = Provider.of<ProfileProvider>(context).curTechStackValue;
    final textTheme = Theme.of(context).textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DisplayText(text: title, style: textTheme.bodyLarge!),
      const Gap(5),
      SingleChildScrollView(
          child: DropdownButtonFormField<int>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down),
        style: textTheme.bodySmall,
        menuMaxHeight: maxHeight,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: text_100)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: text_100)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: text_100)),
        ),
        onChanged: (int? value) {
          Provider.of<ProfileProvider>(context).setCurTechStackValue(value!);
        },
        items: listItem
            .map((e) => DropdownMenuItem<int>(
                  value: listItem.indexOf(e),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e),
                        const Gap(10),
                        const Divider(
                          color: text_100,
                          height: 2,
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

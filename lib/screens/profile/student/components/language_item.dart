import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:student_hub/widgets/widgets.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem(
      {super.key,
      required this.isEdit,
      required this.onEdit,
      required this.language,
      required this.itemsChecked,
      required this.onChangeCheck});
  final LanguageModel language;
  final bool isEdit;
  final List<int> itemsChecked;
  final Function() onEdit;
  final Function(int, bool?) onChangeCheck;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: deviceSize.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DisplayText(
                      text: language.languageName,
                      style: textTheme.bodySmall!,
                    ),
                    DisplayText(
                        text: language.level,
                        style: textTheme.labelSmall!.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.8),
                            fontSize: 12)),
                  ],
                ),
              ),
              if (isEdit)
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: IconButton(
                          iconSize: 20,
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            onEdit();
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: primary_300,
                          )),
                    ),
                    const Gap(25),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              WidgetStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return primary_300;
                            }
                            return Colors.white;
                          }),
                          value: itemsChecked.contains(-1)
                              ? true
                              : itemsChecked.contains(language.id),
                          onChanged: (bool? value) {
                            onChangeCheck(
                              language.id,
                              value,
                            );
                          }),
                    ),
                    const Gap(9),
                  ],
                )
            ],
          ),
        ),
        Divider(
          color: colorScheme.onSurface,
          thickness: 0.2,
        )
      ],
    );
  }
}

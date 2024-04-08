import 'package:flutter/material.dart';
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
      required this.onDelete});
  final LanguageModel language;
  final bool isEdit;
  final Function() onEdit;
  final Function(LanguageModel) onDelete;

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
                    IconButton(
                        iconSize: 23,
                        onPressed: () {
                          onEdit();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: primary_300,
                        )),
                    IconButton(
                        iconSize: 25,
                        onPressed: () {
                          onDelete(language);
                        },
                        color: color_1,
                        icon: const Icon(
                          Icons.delete,
                        )),
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

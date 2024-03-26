import 'package:flutter/material.dart';
import 'package:student_hub/widgets/widgets.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: DisplayText(
            text: text,
            style: textTheme.bodySmall!,
          ),
        ),
        Divider(
          color: colorScheme.onSurface,
        )
      ],
    );
  }
}

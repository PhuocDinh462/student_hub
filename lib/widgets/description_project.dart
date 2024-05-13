import 'package:flutter/material.dart';
import 'package:student_hub/widgets/display_text.dart';

class DescriptionProject extends StatelessWidget {
  const DescriptionProject(
      {super.key, required this.projectDescription, required this.title});
  final String projectDescription;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pjDes = projectDescription.split('.');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(
          text: title,
          style: textTheme.labelLarge!,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pjDes.length > 1
              ? pjDes
                  .where((sentence) => sentence.trim().length > 1)
                  .map((formattedSentence) => Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: DisplayText(
                            text: '• ${formattedSentence.trim()}',
                            style: textTheme.labelSmall!,
                            overflow: TextOverflow.visible),
                      ))
                  .toList()
              : [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 3),
                    child: DisplayText(
                        text: '• ${pjDes[0].trim()}',
                        style: textTheme.labelSmall!,
                        overflow: TextOverflow.visible),
                  )
                ],
        ),
      ],
    );
  }
}

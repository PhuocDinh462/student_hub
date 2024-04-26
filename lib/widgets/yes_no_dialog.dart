import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesText;
  final String noText;
  final VoidCallback? onYesPressed;

  const YesNoDialog({
    super.key,
    this.title = 'Confirmation',
    this.content = 'Are you sure?',
    this.yesText = 'Yes',
    this.noText = 'No',
    this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            noText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.75),
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onYesPressed!();
          },
          child: Text(
            yesText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}

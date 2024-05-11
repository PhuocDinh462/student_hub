import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesText;
  final String noText;
  final VoidCallback? onYesPressed;

  const YesNoDialog({
    super.key,
    this.title = '',
    this.content = '',
    this.yesText = '',
    this.noText = '',
    this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title.isEmpty ? AppLocalizations.of(context)!.confirmationTitle : title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      content: Text(content.isEmpty
          ? AppLocalizations.of(context)!.confirmationContent
          : content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            noText.isEmpty ? AppLocalizations.of(context)!.no : noText,
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
            yesText.isEmpty ? AppLocalizations.of(context)!.yes : yesText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}

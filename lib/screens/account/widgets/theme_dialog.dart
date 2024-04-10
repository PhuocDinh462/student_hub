import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/theme.provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.theme('selectTheme'),
          style: Theme.of(context).textTheme.displayMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: Text(
              AppLocalizations.of(context)!.theme('light'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            value: ThemeMode.light,
            groupValue: themeProvider.getTheme,
            onChanged: (value) {
              themeProvider.setThemeMode(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              AppLocalizations.of(context)!.theme('dark'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            value: ThemeMode.dark,
            groupValue: themeProvider.getTheme,
            onChanged: (value) {
              themeProvider.setThemeMode(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text(
              AppLocalizations.of(context)!.theme('system'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            value: ThemeMode.system,
            groupValue: themeProvider.getTheme,
            onChanged: (value) {
              themeProvider.setThemeMode(value!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

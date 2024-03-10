import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/theme_provider.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return AlertDialog(
      title: Text('Select Theme',
          style: Theme.of(context).textTheme.displayMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: Text(
              'Light Mode',
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
              'Dark Mode',
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
              'System Settings',
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

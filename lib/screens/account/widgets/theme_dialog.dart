import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/theme_provider.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return AlertDialog(
      title: const Text('Select Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeProvider.getTheme,
            onChanged: (value) {
              themeProvider.setThemeMode(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeProvider.getTheme,
            onChanged: (value) {
              themeProvider.setThemeMode(value!);
              Navigator.pop(context);
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
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

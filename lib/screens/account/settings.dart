import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/theme_provider.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:student_hub/constants/colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dark_mode, size: 32),
                        const Gap(10),
                        Text(
                          'Dark mode',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                Switch(
                  value: themeProvider.getThemeMode,
                  onChanged: (value) => themeProvider.setThemeMode(value),
                  activeColor: primary_300,
                  inactiveThumbColor: text_500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

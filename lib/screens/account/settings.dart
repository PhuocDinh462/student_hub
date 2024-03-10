import 'package:flutter/material.dart';
import 'package:language_code/language_code.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/theme_provider.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          // Dark mode
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
                  activeColor: primary_200,
                  inactiveTrackColor: text_200,
                  inactiveThumbColor: text_400,
                ),
              ],
            ),
            const Divider(
              height: 40,
              thickness: .5,
              indent: 40,
              color: text_400,
            ),

            // Language
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, '/account/settings/languages'),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, size: 32),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Language',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(5),
                            Text(
                              LanguageCodes.fromCode(
                                      AppLocalizations.of(context)!.localeName)
                                  .nativeName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

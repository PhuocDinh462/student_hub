import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/theme.provider.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.countryCode,
    required this.languageCode,
    required this.languageName,
  });

  final String countryCode;
  final String languageCode;
  final String languageName;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        themeProvider.setLanguage(languageCode);
        Get.updateLocale(Locale(languageCode));
      },
      child: Material(
        color: Theme.of(context).colorScheme.onPrimary,
        elevation: 3,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? text_700
            : text_100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? text_700
                  : text_300,
              width: .5),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CountryFlag.fromCountryCode(
                    countryCode,
                    height: 48,
                    width: 62,
                    borderRadius: 6,
                  ),
                  const Gap(20),
                  Text(languageName,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              if (themeProvider.getLanguage == languageCode)
                const Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

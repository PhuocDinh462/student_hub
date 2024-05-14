import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/screens/account/widgets/language_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Languages extends StatelessWidget {
  const Languages({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const Gap(20),
          LanguageItem(
            countryCode: 'us',
            languageCode: 'en',
            languageName: AppLocalizations.of(context)!.language('english'),
          ),
          const Gap(20),
          LanguageItem(
            countryCode: 'vn',
            languageCode: 'vi',
            languageName: AppLocalizations.of(context)!.language('vietnamese'),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

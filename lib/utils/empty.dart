import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Empty extends StatelessWidget {
  const Empty({
    super.key,
    this.imgPath = 'assets/images/Empty.png',
    this.text = '',
  });

  final String imgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            width: context.deviceSize.width / 1.5,
          ),
          const Gap(10),
          Text(
            text.isEmpty ? AppLocalizations.of(context)!.noDataAvailable : text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(60),
        ],
      ),
    );
  }
}

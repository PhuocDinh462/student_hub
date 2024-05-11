import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step1 extends StatelessWidget {
  Step1({super.key, required this.next});
  final _formKey = GlobalKey<FormState>();
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              '1/4\t\t\t\t\t${AppLocalizations.of(context)!.postProjectStep1Title}',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Center(
            child: Image.asset(
              'assets/images/Hand-coding.png',
              width: context.deviceSize.width / 1.5,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.postProjectStep1Tip,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          TextFormField(
            initialValue: projectProvider.getTitle,
            onChanged: (value) => projectProvider.setTitle = value,
            scrollPadding: const EdgeInsets.only(bottom: double.infinity),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.blankInputTextError;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.enterYourTitle,
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.all(15),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: text_500,
                  width: 1,
                ),
              ),
            ),
          ),
          const Gap(20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) next();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary_300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(Icons.arrow_forward, color: text_50)),
          ),
        ],
      ),
    );
  }
}

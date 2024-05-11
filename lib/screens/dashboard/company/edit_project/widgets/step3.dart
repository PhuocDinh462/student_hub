import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step3 extends StatelessWidget {
  Step3({super.key, required this.next, required this.back});
  final _formKey = GlobalKey<FormState>();
  final VoidCallback next;
  final VoidCallback back;

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
              '3/4\t\t\t\t\t${AppLocalizations.of(context)!.postProjectStep3Title}',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(20),
          Center(
            child: Image.asset(
              'assets/images/Detailed-analysis.png',
              width: context.deviceSize.width / 1.5,
            ),
          ),
          const Gap(20),
          TextFormField(
            initialValue: projectProvider.getDescription,
            onChanged: (value) => projectProvider.setDescription = value,
            maxLines: 10,
            scrollPadding: const EdgeInsets.only(bottom: double.infinity),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.blankInputTextError;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.describeYourProject,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () => back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? text_800
                            : text_300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.arrow_back, color: text_50)),
              const Gap(15),
              ElevatedButton(
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
            ],
          ),
        ],
      ),
    );
  }
}

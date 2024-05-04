import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormLanguage extends StatelessWidget {
  const FormLanguage(
      {super.key,
      required this.controller,
      required this.keyValidation,
      required this.actionCancel,
      required this.actionSave,
      this.value = ''});
  final TextEditingController controller;
  final GlobalKey<DropdownSearchState<String>> keyValidation;
  final String value;
  final Function() actionCancel;
  final Function() actionSave;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;
    final String typeLang =
        value == '' ? AppLocalizations.of(context)!.native : value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonTextField(
            title: '',
            hintText: AppLocalizations.of(context)!.enterLanguage,
            controller: controller,
          ),
          const Gap(5),
          DropdownSearch<String>(
              key: keyValidation,
              items: [
                AppLocalizations.of(context)!.native,
                AppLocalizations.of(context)!.billingual
              ],
              selectedItem: typeLang,
              dropdownBuilder: (context, selectedItem) {
                return DisplayText(
                  text: selectedItem!,
                  style: textTheme.bodySmall!,
                );
              },
              popupProps: PopupProps.menu(
                  containerBuilder: (context, popupWidget) => Container(
                        width: deviceSize.width,
                        height: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:
                            BoxDecoration(color: colorScheme.onSecondary),
                        child: popupWidget,
                      ),
                  itemBuilder: (context, item, isSelected) {
                    return Container(
                      decoration: !isSelected
                          ? null
                          : BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.amber,
                            ),
                      child: ListTile(
                        selected: isSelected,
                        title: DisplayText(
                          text: item,
                          style: textTheme.bodySmall!,
                        ),
                      ),
                    );
                  }),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  prefixStyle: textTheme.bodySmall!.copyWith(color: text_400),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Gap(15),
              ElevatedButton(
                  style: buttonSecondary,
                  onPressed: () => actionCancel(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
              const Gap(15),
              ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () => actionSave(),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
            ],
          ),
          const Gap(5),
          const Divider(
            color: text_300,
            height: 2,
            thickness: 1,
          )
        ],
      ),
    );
  }
}

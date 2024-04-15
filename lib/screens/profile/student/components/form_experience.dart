import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';

class FormExpericence extends StatefulWidget {
  const FormExpericence(
      {super.key, required this.ps, this.value, required this.actionCancel});
  final ProfileStudentViewModel ps;
  final ExperienceModel? value;
  final Function() actionCancel;

  @override
  State<FormExpericence> createState() => _FormExpericenceState();
}

class _FormExpericenceState extends State<FormExpericence> {
  DateTime startMonth = DateTime.now();
  DateTime endMonth = DateTime.now();
  List<TechnicalModel> skillSets = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desctiptionController = TextEditingController();

  final _popupSkillSetKey = GlobalKey<DropdownSearchState<TechnicalModel>>();

  @override
  void initState() {
    super.initState();

    if (widget.value != null) {
      _titleController.text = widget.value!.title;
      _desctiptionController.text = widget.value!.description;
      startMonth = Helpers.formatMMYYYYToDateTime(widget.value!.startMonth);
      endMonth = Helpers.formatMMYYYYToDateTime(widget.value!.endMonth);

      skillSets = widget.value!.skillSets;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _desctiptionController.dispose();
    _popupSkillSetKey.currentState?.dispose();
    super.dispose();
  }

  void handleDeleteSkillSet(TechnicalModel value) {
    setState(() {
      skillSets.remove(value);
      _popupSkillSetKey.currentState!.changeSelectedItems(skillSets);
    });
  }

  void handleCancelSkillSetInModal() {
    _popupSkillSetKey.currentState!.changeSelectedItems(skillSets);
    Navigator.pop(_popupSkillSetKey.currentContext!);
  }

  void handleUpdateSkillSetInModal(List<TechnicalModel> selectedItems) {
    _popupSkillSetKey.currentState?.popupOnValidate();
    setState(() {
      skillSets = selectedItems;
    });
  }

  void handleChangeYear(DateTime value, int type) {
    setState(() {
      if (type == 1) {
        startMonth = value;
      } else {
        endMonth = value;
      }
    });
  }

  void hanldeSubmitExperience() {
    final experience = ExperienceModel(
      title: _titleController.text,
      description: _desctiptionController.text,
      startMonth: Helpers.formatDateTimeToMMYYYY(startMonth),
      endMonth: Helpers.formatDateTimeToMMYYYY(endMonth),
      skillSets: skillSets,
    );

    if (widget.value != null) {
      widget.ps.setExpById(widget.value!.id, experience);
    } else {
      widget.ps.addExperience(experience);
    }
    widget.ps.updateExperienceStudent();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.onSecondary,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonTextField(
          title: '',
          hintText: 'Enter title project',
          controller: _titleController,
        ),
        const Gap(10),
        Row(
          children: [
            Expanded(
                child: SelectMonthYear(
              title: 'Start',
              actionSelect: (p0) {
                handleChangeYear(p0, 1);
              },
              pickedDate: startMonth,
            )),
            const Gap(10),
            Expanded(
                child: SelectMonthYear(
              title: 'End',
              actionSelect: (p0) {
                handleChangeYear(p0, 2);
              },
              pickedDate: endMonth,
            )),
          ],
        ),
        CommonTextField(
          title: '',
          hintText: 'Enter description project',
          controller: _desctiptionController,
          maxLines: 4,
        ),
        const Gap(10),
        DisplayText(
          text: 'Skillset',
          style: textTheme.bodyLarge!,
        ),
        const Gap(10),
        DropdownSearch<TechnicalModel>.multiSelection(
            key: _popupSkillSetKey,
            items: widget.ps.listSkillset,
            selectedItems: skillSets,
            dropdownBuilder: (context, selectedItems) {
              return Wrap(
                spacing: 10,
                children: selectedItems
                    .map(
                      (e) => Chip(
                        labelStyle: textTheme.labelLarge,
                        deleteIconColor: color_1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side:
                                const BorderSide(color: primary_300, width: 1)),
                        label: DisplayText(
                            text: e.name, style: textTheme.labelSmall!),
                        onDeleted: () {
                          handleDeleteSkillSet(e);
                        },
                      ),
                    )
                    .toList(),
              );
            },
            popupProps: PopupPropsMultiSelection.dialog(
                validationWidgetBuilder: (ctx, selectedItems) {
                  return Column(
                    children: [
                      const Gap(10),
                      const Divider(
                        color: text_300,
                        height: 1,
                      ),
                      const Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Gap(15),
                          ElevatedButton(
                              style: buttonSecondary,
                              onPressed: () {
                                handleCancelSkillSetInModal();
                              },
                              child: DisplayText(
                                text: 'Cancel',
                                style: textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              )),
                          const Gap(15),
                          ElevatedButton(
                              style: buttonPrimary,
                              onPressed: () {
                                handleUpdateSkillSetInModal(selectedItems);
                              },
                              child: DisplayText(
                                text: 'Save',
                                style: textTheme.labelLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ],
                  );
                },
                containerBuilder: (context, popupWidget) => Container(
                      width: deviceSize.width,
                      height: deviceSize.height * 0.8,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: colorScheme.onSecondary),
                      child: popupWidget,
                    ),
                title: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: DisplayText(
                          text: 'Select skillset',
                          style: textTheme.titleLarge!,
                        )),
                    const Divider(
                      color: text_300,
                      height: 1,
                    ),
                    const Gap(10),
                  ],
                ),
                itemBuilder: (context, item, isSelected) {
                  return Container(
                    decoration: !isSelected
                        ? null
                        : BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(5),
                            color: colorScheme.onSecondary,
                          ),
                    child: ListTile(
                      selected: isSelected,
                      title: DisplayText(
                        text: item.name,
                        style: textTheme.bodySmall!,
                      ),
                    ),
                  );
                }),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                prefixText: skillSets.isEmpty ? 'Select skillsets' : '',
                prefixStyle: textTheme.bodySmall!.copyWith(color: text_400),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            )),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Gap(15),
            ElevatedButton(
                style: buttonSecondary,
                onPressed: () => {widget.actionCancel()},
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
            const Gap(15),
            ElevatedButton(
                style: buttonPrimary,
                onPressed: () {
                  hanldeSubmitExperience();
                  widget.actionCancel();
                },
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                )),
          ],
        ),
        const Gap(20)
      ]),
    );
  }
}

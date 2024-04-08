import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:student_hub/screens/profile/student/components/components.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:student_hub/view-models/view_models.dart';

import 'package:student_hub/widgets/widgets.dart';

class ProfileStudentStepOne extends StatefulWidget {
  const ProfileStudentStepOne({super.key});

  @override
  State<ProfileStudentStepOne> createState() => _ProfileStudentStepOneState();
}

class _ProfileStudentStepOneState extends State<ProfileStudentStepOne> {
  String valueDrop = 'FullStack Engineer';
  bool langEdit = false;
  bool langAdd = false;
  final TextEditingController _titleController = TextEditingController();
  final _popupSkillSetKey = GlobalKey<DropdownSearchState<TechnicalModel>>();

  final TextEditingController _languageController = TextEditingController();
  final _popupLanguageKey = GlobalKey<DropdownSearchState<String>>();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  List<String> educations = [
    'Le Hong Phong Hight School',
    'Le Hong Phong Hight School',
    'Le Hong Phong Hight School'
  ];

  List<TechnicalModel> lstTechStack = [];

  void onSelectTechStack(int value) {
    final profileStudentViewModel =
        Provider.of<ProfileStudentViewModel>(context, listen: false);
    profileStudentViewModel
        .setTechStack(profileStudentViewModel.listTechStack[value]);
    profileStudentViewModel.setIsChange(true);
  }

  void handleUpdateLanguage(ProfileStudentViewModel ps) {
    ps.updateLanguageStudent(6);
  }

  void handleAddLanguage(ProfileStudentViewModel ps) {
    LanguageModel newLang = LanguageModel(
        languageName: _languageController.text,
        level: _popupLanguageKey.currentState!.getSelectedItem!);

    ps.addLanguage(newLang);
    handleUpdateLanguage(ps);
    setState(() {
      langAdd = false;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileStudent =
          Provider.of<ProfileStudentViewModel>(context, listen: false);
      profileStudent.fetchProfileStudent(6);
      profileStudent.fetchTechnicalData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.onPrimary,
        body: Stack(
          children: [
            Consumer<ProfileStudentViewModel>(
                builder: (context, profileStudentModel, child) {
              if (profileStudentModel.loading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 130),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DisplayText(
                          text: 'Welcome to Student Hub',
                          style: textTheme.headlineLarge!,
                          textAlign: TextAlign.center,
                        ),
                        const Gap(10),
                        DisplayText(
                          text:
                              'Tell us about your self and you will be on your way connect with real-world projects.',
                          style: textTheme.bodySmall!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                        const Gap(20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CommonDropdown(
                                listItem: profileStudentModel.listTechStack,
                                title: 'Techstack',
                                keyValue: 'name',
                                value:
                                    profileStudentModel.student.techStack.id!,
                                onChange: (int value) =>
                                    onSelectTechStack(value),
                              ),
                              const Gap(20),
                              DisplayText(
                                text: 'Skillset',
                                style: textTheme.bodyLarge!,
                              ),
                              const Gap(10),
                              DropdownSearch<TechnicalModel>.multiSelection(
                                  key: _popupSkillSetKey,
                                  items: profileStudentModel.listSkillset,
                                  selectedItems:
                                      profileStudentModel.student.skillSets,
                                  dropdownBuilder: (context, selectedItems) {
                                    return Wrap(
                                      spacing: 10,
                                      children: selectedItems
                                          .map(
                                            (e) => Chip(
                                              labelStyle: textTheme.labelLarge,
                                              deleteIconColor: color_1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  side: const BorderSide(
                                                      color: primary_300,
                                                      width: 1)),
                                              label: DisplayText(
                                                  text: e.name,
                                                  style: textTheme.labelSmall!),
                                              onDeleted: () {
                                                profileStudentModel
                                                    .removeSkillset(e);
                                                profileStudentModel
                                                    .setIsChange(true);
                                              },
                                            ),
                                          )
                                          .toList(),
                                    );
                                  },
                                  popupProps: PopupPropsMultiSelection.dialog(
                                      validationWidgetBuilder:
                                          (ctx, selectedItems) {
                                        return Column(
                                          children: [
                                            const Gap(10),
                                            const Divider(
                                              color: text_300,
                                              height: 1,
                                            ),
                                            const Gap(15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Gap(15),
                                                ElevatedButton(
                                                    style: buttonSecondary,
                                                    onPressed: () => {
                                                          _popupSkillSetKey
                                                              .currentState
                                                              ?.popupOnValidate()
                                                        },
                                                    child: DisplayText(
                                                      text: 'Cancel',
                                                      style: textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                const Gap(15),
                                                ElevatedButton(
                                                    style: buttonPrimary,
                                                    onPressed: () => {
                                                          profileStudentModel
                                                              .updateSkillSet(
                                                                  selectedItems),
                                                          _popupSkillSetKey
                                                              .currentState
                                                              ?.popupOnValidate(),
                                                          profileStudentModel
                                                              .setIsChange(true)
                                                        },
                                                    child: DisplayText(
                                                      text: 'Save',
                                                      style: textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                      containerBuilder: (context,
                                              popupWidget) =>
                                          Container(
                                            width: deviceSize.width,
                                            height: deviceSize.height * 0.8,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: colorScheme.onSecondary),
                                            child: popupWidget,
                                          ),
                                      title: Column(
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
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
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
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
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      prefixText: profileStudentModel
                                              .student.skillSets.isEmpty
                                          ? 'Select skillsets'
                                          : '',
                                      prefixStyle: textTheme.bodySmall!
                                          .copyWith(color: text_400),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  )),
                              const Gap(10),
                              if (profileStudentModel.isChange)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        style: buttonSecondary,
                                        onPressed: () => {
                                              profileStudentModel
                                                  .fetchProfileStudent(6)
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
                                        onPressed: () => {
                                              profileStudentModel
                                                  .updateProfileStudent(6)
                                            },
                                        child: DisplayText(
                                          text: 'Save',
                                          style: textTheme.labelLarge!.copyWith(
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                )
                            ],
                          ),
                        ),
                        const Gap(10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DisplayText(
                                      text: 'Languages',
                                      style: textTheme.bodyLarge!),
                                  langEdit
                                      ? IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            setState(() {
                                              langEdit = false;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: color_1,
                                          ))
                                      : Row(children: [
                                          IconButton(
                                              iconSize: 30,
                                              onPressed: () {
                                                setState(() {
                                                  langAdd = true;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                              )),
                                          IconButton(
                                              iconSize: 25,
                                              onPressed: () {
                                                setState(() {
                                                  langEdit = true;
                                                });
                                              },
                                              icon: const Icon(Icons.edit)),
                                        ])
                                ],
                              ),
                              if (langAdd)
                                FormLanguage(
                                  controller: _languageController,
                                  keyValidation: _popupLanguageKey,
                                  actionCancel: () => {
                                    setState(() {
                                      langAdd = false;
                                    })
                                  },
                                  actionSave: () {
                                    handleAddLanguage(profileStudentModel);
                                  },
                                ),
                              if (profileStudentModel
                                  .student.languages.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Column(
                                    children:
                                        profileStudentModel.student.languages
                                            .map((e) => LanguageItem(
                                                  isEdit: false,
                                                  language: e,
                                                  onDelete: (item) {},
                                                  onEdit: () {
                                                    handleUpdateLanguage(
                                                        profileStudentModel);
                                                  },
                                                ))
                                            .toList(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DisplayText(
                                  text: 'Education',
                                  style: textTheme.bodyLarge!),
                              IconButton(
                                  iconSize: 30,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                  ))
                            ]),
                        Column(
                          children: educations
                              .map((e) => const EducationItem())
                              .toList(),
                        )
                      ]),
                ),
              );
            }),
            if (!Provider.of<GlobalProvider>(context, listen: true).isFocus)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: deviceSize.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: colorScheme.onSurface.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, -3),
                    ),
                  ]),
                  child: ElevatedButton(
                      style: buttonPrimary,
                      onPressed: () => Navigator.pushNamed(
                          context, StudentRoutes.profileStudentStepTwo),
                      child: DisplayText(
                        text: 'Next',
                        style: textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                      )),
                ),
              )
          ],
        ));
  }
}

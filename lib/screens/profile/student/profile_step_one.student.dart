import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
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
  bool langEdit = false;
  bool langAdd = false;
  bool eduEdit = false;
  bool eduAdd = false;

  List<int> itemsLangChecked = [];
  List<int> itemsEduChecked = [];

  DateTime yearStart = DateTime.now();
  DateTime yearEnd = DateTime.now();

  final TextEditingController _titleController = TextEditingController();
  final _popupSkillSetKey = GlobalKey<DropdownSearchState<TechnicalModel>>();

  final TextEditingController _languageController = TextEditingController();
  final _popupLanguageKey = GlobalKey<DropdownSearchState<String>>();

  final TextEditingController _eduController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileStudent =
          Provider.of<ProfileStudentViewModel>(context, listen: false);

      profileStudent.fetchProfileStudent();
      profileStudent.fetchTechnicalData();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _languageController.dispose();
    _eduController.dispose();
    _popupSkillSetKey.currentState?.dispose();
    _popupLanguageKey.currentState?.dispose();
    super.dispose();
  }

  void onSelectTechStack(int value) {
    final profileStudentViewModel =
        Provider.of<ProfileStudentViewModel>(context, listen: false);
    profileStudentViewModel
        .setTechStack(profileStudentViewModel.listTechStack[value]);
    profileStudentViewModel.setIsChange(true);
  }

  void handleUpdateSkillSetInModal(
      ProfileStudentViewModel ps, List<TechnicalModel> selectedItems) {
    _popupSkillSetKey.currentState?.popupOnValidate();
    ps.updateSkillSet(selectedItems);
    ps.setIsChange(true);
  }

  void handleCancelSkillSetInModal(
    ProfileStudentViewModel ps,
  ) {
    _popupSkillSetKey.currentState!.changeSelectedItems(ps.student.skillSets);
    Navigator.pop(_popupSkillSetKey.currentContext!);
  }

  void handleAddLanguage(ProfileStudentViewModel ps) {
    LanguageModel newLang = LanguageModel(
        languageName: _languageController.text,
        level: _popupLanguageKey.currentState!.getSelectedItem!);

    ps.addLanguage(newLang);
    ps.updateLanguageStudent();
  }

  void handleSaveLanguage(
    int id,
    ProfileStudentViewModel ps,
  ) {
    LanguageModel newLang = LanguageModel(
        languageName: _languageController.text,
        level: _popupLanguageKey.currentState!.getSelectedItem!);

    ps.setLanguageById(id, newLang);
    ps.updateLanguageStudent();
  }

  void handleDeleteLanguage(
    ProfileStudentViewModel ps,
  ) {
    if (itemsLangChecked.contains(-1)) {
      ps.setLanguage([]);
      setState(() {
        langEdit = !itemsLangChecked.contains(-1);
      });
    } else {
      ps.setLanguage(ps.student.languages
          .where((element) => !itemsLangChecked.contains(element.id))
          .toList());
    }
    ps.updateLanguageStudent();
  }

  void eventUpdateItemsLangChecked(int id, bool value) {
    setState(() {
      if (value) {
        itemsLangChecked.add(id);
      } else {
        itemsLangChecked.remove(id);
      }
    });
  }

  void handleEditLanguage(ProfileStudentViewModel ps, LanguageModel lag) {
    _languageController.text = lag.languageName;

    ps.setEditLanguageById(lag.id, true);
  }

  void eventCheckBoxAllLang(bool value) {
    setState(() {
      itemsLangChecked = value ? [-1] : [];
    });
  }

  void handleAddEdu(ProfileStudentViewModel ps) {
    EducationModel newEdu = EducationModel(
      schoolName: _eduController.text,
      startYear: yearStart.year,
      endYear: yearEnd.year,
    );

    ps.addEducation(newEdu);
    ps.updateEducationStudent();

    setState(() {
      eduAdd = false;
    });
  }

  void handleSaveEdu(
    int id,
    ProfileStudentViewModel ps,
  ) {
    EducationModel newEdu = EducationModel(
      schoolName: _eduController.text,
      startYear: yearStart.year,
      endYear: yearEnd.year,
    );

    ps.setEduById(id, newEdu);
    ps.updateEducationStudent();
    ps.setEditEduById(id, false);
  }

  void handleEditEdu(ProfileStudentViewModel ps, EducationModel edu) {
    _eduController.text = edu.schoolName;

    handleChangeYear(DateTime(edu.startYear), 1);
    handleChangeYear(DateTime(edu.endYear), 2);

    ps.setEditEduById(edu.id, true);
  }

  void handleChangeYear(DateTime dateTime, int whatChange) {
    setState(() {
      if (whatChange == 1) {
        yearStart = dateTime;
      } else {
        yearEnd = dateTime;
      }
    });
  }

  void eventCheckBoxAllEdu(bool value) {
    setState(() {
      itemsEduChecked = value ? [-1] : [];
    });
  }

  void eventUpdateItemsEduChecked(int id, bool value) {
    setState(() {
      if (value) {
        itemsEduChecked.add(id);
      } else {
        itemsEduChecked.remove(id);
      }
    });
  }

  void handleDeleteEdu(
    ProfileStudentViewModel ps,
  ) {
    if (itemsEduChecked.contains(-1)) {
      ps.setEducation([]);
      setState(() {
        eduEdit = !itemsEduChecked.contains(-1);
      });
    } else {
      ps.setEducation(ps.student.educations
          .where((element) => !itemsEduChecked.contains(element.id))
          .toList());
    }
    ps.updateEducationStudent();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: colorScheme.secondaryContainer,
        body: ConstrainedBox(
          constraints: BoxConstraints(minHeight: deviceSize.height),
          child: Stack(
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
                        top: 20, left: 10, right: 10, bottom: 130),
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
                          widgetProfile(profileStudentModel, textTheme,
                              deviceSize, colorScheme),
                          const Gap(10),
                          widgetLanguage(textTheme, profileStudentModel,
                              deviceSize, colorScheme),
                          const Gap(10),
                          widgetEducation(textTheme, profileStudentModel,
                              deviceSize, colorScheme),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.onSurface.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, -3),
                          ),
                        ]),
                    child: ElevatedButton(
                        style: buttonPrimary,
                        onPressed: () {
                          if (user.currentUser!.currentRole == Role.student) {
                            Get.toNamed(StudentRoutes.profileStudentStepTwo);
                          } else {
                            Get.toNamed(CompanyRoutes.profileStudentStepTwo);
                          }
                        },
                        child: DisplayText(
                          text: 'Next',
                          style: textTheme.labelLarge!.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        )),
                  ),
                )
            ],
          ),
        ));
  }

  Container widgetLanguage(
      TextTheme textTheme,
      ProfileStudentViewModel profileStudentModel,
      Size deviceSize,
      ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorScheme.onSecondary),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DisplayText(text: 'Languages', style: textTheme.bodyLarge!),
              langEdit
                  ? Row(
                      children: [
                        if (itemsLangChecked.isNotEmpty)
                          IconButton(
                              iconSize: 30,
                              onPressed: () {
                                handleDeleteLanguage(profileStudentModel);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: color_1,
                              )),
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                langEdit = false;
                                itemsLangChecked = [];
                                profileStudentModel.setEditLanguage(false);
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: color_1,
                            )),
                        Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.selected)) {
                                return primary_300;
                              }
                              return Colors.white;
                            }),
                            value: itemsLangChecked.contains(-1),
                            onChanged: (bool? value) {
                              eventCheckBoxAllLang(value!);
                            }),
                      ],
                    )
                  : Row(children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              langAdd = true;
                              _languageController.text = '';
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                          )),
                      if (profileStudentModel.student.languages.isNotEmpty)
                        IconButton(
                            iconSize: 25,
                            onPressed: () {
                              setState(() {
                                langEdit = true;
                                langAdd = false;
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
                setState(() {
                  langAdd = false;
                });
              },
            ),
          if (profileStudentModel.student.languages.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: deviceSize.height * 0.6,
                  minWidth: double.infinity),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListView.builder(
                    itemCount: profileStudentModel.student.languages.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      LanguageModel tmp =
                          profileStudentModel.student.languages[index];
                      return tmp.isEdit
                          ? FormLanguage(
                              controller: _languageController,
                              keyValidation: _popupLanguageKey,
                              value: tmp.level,
                              actionCancel: () => {
                                profileStudentModel.setEditLanguageById(
                                    tmp.id, false)
                              },
                              actionSave: () {
                                handleSaveLanguage(
                                  tmp.id,
                                  profileStudentModel,
                                );
                                profileStudentModel.setEditLanguageById(
                                    tmp.id, false);
                              },
                            )
                          : LanguageItem(
                              isEdit: langEdit,
                              language: tmp,
                              itemsChecked: itemsLangChecked,
                              onChangeCheck: (p0, p1) {
                                eventUpdateItemsLangChecked(p0, p1!);
                              },
                              onEdit: () {
                                handleEditLanguage(profileStudentModel, tmp);
                              },
                            );
                    },
                  )),
            ),
        ],
      ),
    );
  }

  Container widgetEducation(
      TextTheme textTheme,
      ProfileStudentViewModel profileStudentModel,
      Size deviceSize,
      ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorScheme.onSecondary),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DisplayText(text: 'Education', style: textTheme.bodyLarge!),
              eduEdit
                  ? Row(
                      children: [
                        if (itemsEduChecked.isNotEmpty)
                          IconButton(
                              iconSize: 30,
                              onPressed: () {
                                handleDeleteEdu(profileStudentModel);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: color_1,
                              )),
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                eduEdit = false;
                                itemsEduChecked = [];
                                profileStudentModel.setEditEdu(false);
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: color_1,
                            )),
                        Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.selected)) {
                                return primary_300;
                              }
                              return Colors.white;
                            }),
                            value: itemsEduChecked.contains(-1),
                            onChanged: (bool? value) {
                              eventCheckBoxAllEdu(value!);
                            }),
                      ],
                    )
                  : Row(children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              eduAdd = true;
                              _eduController.text = '';
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                          )),
                      if (profileStudentModel.student.educations.isNotEmpty)
                        IconButton(
                            iconSize: 25,
                            onPressed: () {
                              setState(() {
                                eduEdit = true;
                                eduAdd = false;
                              });
                            },
                            icon: const Icon(Icons.edit)),
                    ])
            ],
          ),
          if (eduAdd)
            FormEdu(
              controller: _eduController,
              yearEnd: yearEnd,
              yearStart: yearStart,
              actionSave: () {
                handleAddEdu(profileStudentModel);
              },
              actionCancel: () {
                setState(() {
                  eduAdd = false;
                });
              },
              actionChangeStartYear: (DateTime time) {
                handleChangeYear(time, 1);
              },
              actionChangeEndYear: (DateTime time) {
                handleChangeYear(time, 2);
              },
            ),
          if (profileStudentModel.student.educations.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: deviceSize.height * 0.6,
                  minWidth: double.infinity),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListView.builder(
                    itemCount: profileStudentModel.student.educations.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      EducationModel tmp =
                          profileStudentModel.student.educations[index];

                      return tmp.isEdit
                          ? FormEdu(
                              controller: _eduController,
                              yearStart: yearStart,
                              yearEnd: yearEnd,
                              actionSave: () {
                                handleSaveEdu(tmp.id, profileStudentModel);
                              },
                              actionCancel: () {
                                profileStudentModel.setEditEduById(
                                    tmp.id, false);
                              },
                              actionChangeStartYear: (DateTime time) {
                                handleChangeYear(time, 1);
                              },
                              actionChangeEndYear: (DateTime time) {
                                handleChangeYear(time, 2);
                              },
                            )
                          : EducationItem(
                              edu: tmp,
                              isEdit: eduEdit,
                              itemsChecked: itemsEduChecked,
                              onEdit: () {
                                handleEditEdu(profileStudentModel, tmp);
                              },
                              onChangeCheck: (p0, p1) {
                                eventUpdateItemsEduChecked(p0, p1!);
                              },
                            );
                    },
                  )),
            ),
        ],
      ),
    );
  }

  Container widgetProfile(ProfileStudentViewModel profileStudentModel,
      TextTheme textTheme, Size deviceSize, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorScheme.onSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonDropdown(
            listItem: profileStudentModel.listTechStack,
            title: 'Techstack',
            keyValue: 'name',
            value: profileStudentModel.student.techStack.id,
            onChange: (int value) => onSelectTechStack(value),
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
              selectedItems: profileStudentModel.student.skillSets,
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
                              side: const BorderSide(
                                  color: primary_300, width: 1)),
                          label: DisplayText(
                              text: e.name, style: textTheme.labelSmall!),
                          onDeleted: () {
                            profileStudentModel.removeSkillset(e);
                            profileStudentModel.setIsChange(true);
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
                                  handleCancelSkillSetInModal(
                                      profileStudentModel);
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
                                  handleUpdateSkillSetInModal(
                                      profileStudentModel, selectedItems);
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
                  prefixText: profileStudentModel.student.skillSets.isEmpty
                      ? 'Select skillsets'
                      : '',
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
          if (profileStudentModel.isChange)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: buttonSecondary,
                    onPressed: () {
                      profileStudentModel.fetchProfileStudent();
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
                      profileStudentModel.updateProfileStudent();
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
    );
  }
}

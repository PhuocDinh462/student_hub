import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/profile/student/components/components.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/extensions.dart';

import 'package:student_hub/widgets/chip_list.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileStudentStepOne extends StatefulWidget {
  const ProfileStudentStepOne({super.key});

  @override
  State<ProfileStudentStepOne> createState() => _ProfileStudentStepOneState();
}

class _ProfileStudentStepOneState extends State<ProfileStudentStepOne> {
  String valueDrop = 'FullStack Engineer';
  bool langEdit = false;
  final TextEditingController _titleController = TextEditingController();

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

  List<String> languages = [
    'English: Native or Bilingual',
    'English',
    'Vietnamese',
    'Japanese',
    'Chinese',
    'Korea',
    'Swedish',
  ];

  List<String> languagesSelected = [
    'English: Native or Bilingual',
    'English',
    'Vietnamese',
  ];

  List<String> skills = [
    'Reactjs',
    'Nodejs',
    'Flutter',
    'Dart',
    'Python',
    'JavaScript',
    'C/C++'
  ];

  List<String> lst = [
    'FullStack Engineer',
    'Frontend Engineer',
    'Backend Engineer',
    'Mobile Engineer',
    'DevOps Engineer',
    'Data Engineer',
    'Data Scientist',
    'Product Manager',
    'UX/UI Designer',
    'QA Engineer',
    'Security Engineer',
    'Network Engineer',
    'Cloud Engineer',
    'Game Developer',
    'Embedded Engineer',
    'AI/ML Engineer',
    'AR/VR Engineer',
    'Blockchain Engineer',
    'Robotics Engineer',
    'Other Engineer'
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        SingleChildScrollView(
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
                  ),
                  const Gap(20),
                  CommonDropdownText(
                    listItem: lst,
                    title: 'Techstack',
                  ),
                  const Gap(20),
                  const CommonTextField(
                      title: 'Skillset', hintText: 'Add your skill'),
                  ChipList(listChip: skills),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DisplayText(
                          text: 'Languages', style: textTheme.bodyLarge!),
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
                              ))
                          : Row(children: [
                              IconButton(
                                  iconSize: 30,
                                  onPressed: () => showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          backgroundColor:
                                              colorScheme.background,
                                          title: DisplayText(
                                              text: 'Languages',
                                              style: textTheme.headlineLarge!),
                                          content: SizedBox(
                                              height: 300,
                                              width: deviceSize.width,
                                              child: ListView.builder(
                                                itemCount: languages.length,
                                                itemBuilder: (ctx, index) =>
                                                    Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color:
                                                              text_500), // This adds a border at the bottom
                                                    ),
                                                  ),
                                                  child: CheckboxListTile(
                                                    title: DisplayText(
                                                      text: languages[index],
                                                      style:
                                                          textTheme.bodySmall!,
                                                    ),
                                                    value: languagesSelected
                                                        .contains(
                                                            languages[index]),
                                                    onChanged: (bool? value) {},
                                                  ),
                                                ),
                                              )),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: DisplayText(
                                                  text: 'Save',
                                                  style: textTheme.labelLarge!
                                                      .copyWith(
                                                    color: colorScheme.primary,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: languagesSelected
                          .map((e) => LanguageItem(
                                text: e,
                              ))
                          .toList(),
                    ),
                  ),
                  const Gap(20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DisplayText(
                            text: 'Education', style: textTheme.bodyLarge!),
                        IconButton(
                            iconSize: 30,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                            ))
                      ]),
                  Column(
                    children: educations.map((e) => EducationItem()).toList(),
                  )
                ]),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: deviceSize.width,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                onPressed: () {},
                child: DisplayText(
                  text: 'Next',
                  style: textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }
}

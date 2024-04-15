import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/screens/profile/student/components/components.dart';
import 'package:student_hub/styles/button_style.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileStudentStepTwo extends StatefulWidget {
  const ProfileStudentStepTwo({super.key});

  @override
  State<ProfileStudentStepTwo> createState() => _ProfileStudentStepTwoState();
}

class _ProfileStudentStepTwoState extends State<ProfileStudentStepTwo> {
  bool isAdd = false;

  void handleCancelAdd() {
    setState(() {
      isAdd = false;
    });
  }

  void handleOpenAdd() {
    setState(() {
      isAdd = true;
    });
  }

  void handleDeleteExperience(
      ProfileStudentViewModel ps, ExperienceModel value) {
    ps.removeExperience(value);
    ps.updateExperienceStudent();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);

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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DisplayText(
                        text: 'Experiences',
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DisplayText(
                                text: 'Projects', style: textTheme.bodyLarge!),
                            IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  handleOpenAdd();
                                },
                                icon: const Icon(
                                  Icons.add,
                                ))
                          ]),
                      if (isAdd)
                        FormExpericence(
                            ps: profileStudentModel,
                            actionCancel: () {
                              handleCancelAdd();
                            }),
                      if (profileStudentModel.student.experiences.isEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colorScheme.onSecondary),
                          child: Column(
                            children: [
                              const Gap(20),
                              DisplayText(
                                style: textTheme.headlineMedium!.copyWith(
                                  color: colorScheme.primary,
                                ),
                                text: 'Add more to your experience',
                              ),
                              const Gap(20),
                              Container(
                                width: 200,
                                height: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/exp-student.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: deviceSize.height * 0.6,
                        child: ListView.builder(
                            itemCount:
                                profileStudentModel.student.experiences.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              ExperienceModel exp = profileStudentModel
                                  .student.experiences[index];

                              return exp.isEdit
                                  ? FormExpericence(
                                      value: exp,
                                      ps: profileStudentModel,
                                      actionCancel: () {
                                        profileStudentModel.setEditExpById(
                                            exp.id, false);
                                      })
                                  : ExperienceItem(
                                      exp: exp,
                                      actionDelete: () {
                                        handleDeleteExperience(
                                            profileStudentModel, exp);
                                      },
                                      actionEdit: () {
                                        profileStudentModel.setEditExpById(
                                            exp.id, true);
                                      },
                                    );
                            }),
                      )
                    ],
                  ),
                ),
              );
            }),
            if (!Provider.of<GlobalProvider>(context, listen: true).isFocus)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: deviceSize.width,
                  padding: const EdgeInsets.all(30),
                  decoration:
                      BoxDecoration(color: colorScheme.onSecondary, boxShadow: [
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
                          Get.toNamed(StudentRoutes.profileStudentStepThree);
                        } else {
                          Get.toNamed(CompanyRoutes.profileStudentStepThree);
                        }
                      },
                      child: DisplayText(
                        text: 'Next',
                        style: textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                      )),
                ),
              )
          ],
        ),
      ),
    );
  }
}

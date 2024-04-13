import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/picked_image.dart';

import 'package:student_hub/widgets/widgets.dart';

class ProfileStudentStepThree extends StatefulWidget {
  const ProfileStudentStepThree({super.key});

  @override
  State<ProfileStudentStepThree> createState() =>
      _ProfileStudentStepThreeState();
}

class _ProfileStudentStepThreeState extends State<ProfileStudentStepThree> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: Consumer<ProfileStudentViewModel>(
          builder: (context, profileStudentModel, child) {
        if (profileStudentModel.loading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: deviceSize.height),
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 130),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DisplayText(
                              text: 'CV & Transcript',
                              style: textTheme.headlineLarge!,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(10),
                            DisplayText(
                              text:
                                  'Tell us about your self and you will be on your way connect with real-world project.',
                              style: textTheme.bodySmall!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            ),
                            const Gap(20),
                            PickedImage(
                                label: 'Resume/CV (*)',
                                ps: profileStudentModel,
                                urlFile: profileStudentModel.student.resume,
                                actionUpdate: (p0) => {
                                      profileStudentModel
                                          .updateResumeStudent(p0!)
                                    }),
                            const Gap(20),
                            PickedImage(
                                label: 'Transcript (*)',
                                ps: profileStudentModel,
                                urlFile: profileStudentModel.student.transcript,
                                actionUpdate: (p0) => {
                                      profileStudentModel
                                          .updateTranscriptStudent(p0!)
                                    })
                          ]))),
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
                      onPressed: () {
                        if (user.currentUser!.currentRole == Role.student) {
                          Navigator.pushNamed(
                            context,
                            StudentRoutes.nav,
                          );
                        } else {
                          user.setCurrentUser(user.currentUser!.copyWith(
                              currentRole: Role.student,
                              roles: [Role.company, Role.student]));
                        }
                      },
                      child: DisplayText(
                        text: 'Continue',
                        style: textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                      )),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

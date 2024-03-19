import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileCompanyInput extends StatefulWidget {
  const ProfileCompanyInput({super.key});

  @override
  ProfileCompanyInputState createState() => ProfileCompanyInputState();
}

class ProfileCompanyInputState extends State<ProfileCompanyInput> {
  bool isHaveInfo = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: DisplayText(
                        text: 'Welcome to Student Hub',
                        style: textTheme.displayLarge!,
                      )),
                  if (!isHaveInfo)
                    Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 17, right: 17),
                        child: DisplayText(
                          text:
                              'Tell us about your company and you will be on your way connect with high-skilled students.',
                          style: textTheme.bodySmall!,
                          textAlign: TextAlign.center,
                        )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            verticalDirection: isHaveInfo
                                ? VerticalDirection.up
                                : VerticalDirection.down,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 10, top: 30),
                                      child: DisplayText(
                                        text:
                                            'How many people are in your company?',
                                        style: textTheme.bodyLarge!,
                                      )),
                                  const DisplayRadioList(),
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                margin: const EdgeInsets.only(top: 20),
                                child: const Column(children: [
                                  CommonTextField(
                                    title: 'Company name',
                                    hintText: 'Your company',
                                  ),
                                  Gap(20),
                                  CommonTextField(
                                    title: 'Website',
                                    hintText: 'Your website',
                                  ),
                                  Gap(20),
                                  CommonTextField(
                                    title: 'Description',
                                    hintText: 'Your description',
                                    maxLines: 3,
                                  ),
                                ]),
                              ),
                            ]),
                        const Gap(15),
                        if (!isHaveInfo)
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: buttonPrimary,
                                    onPressed: () => Navigator.pushNamed(
                                        context, AppRoutes.welcomeCompany),
                                    child: DisplayText(
                                      text: 'Continue',
                                      style: textTheme.labelLarge!.copyWith(
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        if (isHaveInfo)
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: buttonPrimary,
                                    onPressed: () {},
                                    child: DisplayText(
                                      text: 'Edit',
                                      style: textTheme.labelLarge!.copyWith(
                                        color: Colors.white,
                                      ),
                                    )),
                                const Gap(15),
                                ElevatedButton(
                                    style: buttonSecondary,
                                    onPressed: () {},
                                    child: DisplayText(
                                      text: 'Cancel',
                                      style: textTheme.labelLarge!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}

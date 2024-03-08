import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProfileInput extends StatelessWidget {
  const ProfileInput({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: const DisplayText(
                      text: 'Welcome to Student Hub',
                      color: text_800,
                      fontWeight: FontWeight.w600,
                      size: 24,
                    )),
                Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 17, right: 17),
                    child: const DisplayText(
                      text:
                          'Tell us about your company and you will be on your way connect with high-skilled students.',
                      color: text_600,
                      fontWeight: FontWeight.w400,
                      size: 16,
                      textAlign: TextAlign.center,
                    )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                      // verticalDirection: VerticalDirection.up,
                      children: [
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 15, bottom: 10, top: 30),
                                child: const DisplayText(
                                  text: 'How many people are in your company?',
                                  color: text_900,
                                  fontWeight: FontWeight.w600,
                                  size: 16,
                                )),
                            const DisplayRadioList(),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: const Column(children: [
                            CommonTextField(
                                title: 'Company name',
                                hintText: 'Your company'),
                            Gap(20),
                            CommonTextField(
                                title: 'Website', hintText: 'Your website'),
                            Gap(20),
                            CommonTextField(
                              title: 'Description',
                              hintText: 'Your description',
                              maxLines: 3,
                            ),
                          ]),
                        ),
                      ]),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: buttonPrimary,
                          onPressed: () {},
                          child: const DisplayText(
                            text: 'Continue',
                            color: Colors.white,
                            size: 18,
                            fontWeight: FontWeight.w400,
                          )),
                      const Gap(15),
                      ElevatedButton(
                          style: buttonSecondary,
                          onPressed: () {},
                          child: const DisplayText(
                            text: 'Cancel',
                            color: Colors.white,
                            size: 18,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  )
                ])
              ],
            ),
          ),
        )));
  }
}

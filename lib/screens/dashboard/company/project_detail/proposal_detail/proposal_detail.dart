import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/proposal_detail/widgets/skill_item.dart';
import 'package:student_hub/utils/extensions.dart';
// import 'package:get/get.dart';

class ProposalDetail extends StatelessWidget {
  const ProposalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // final int proposalId = Get.arguments;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              Row(
                children: [
                  Image.asset(
                    'assets/images/user.png',
                    width: 80,
                  ),
                  const Gap(20),
                  SizedBox(
                    width: context.deviceSize.width - 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phuoc Dinh Cao Hong',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const Gap(5),
                        Text(
                          'Fullstack Engineer',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Gap(15),

              // Cover letter
              SizedBox(
                width: context.deviceSize.width - 30,
                child: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
              ),
              const Gap(30),

              // Educations
              Row(
                children: [
                  Text(
                    'Educations',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 40,
                      thickness: .5,
                      indent: 30,
                      color: text_400,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('University of Science - VNUHCM'),
                  Text(
                    '2020 - 2024',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const Gap(15),
                  const Text('University of Science - VNUHCM'),
                  Text(
                    '2020 - 2024',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              const Gap(30),

              // Skills
              Row(
                children: [
                  Text(
                    'Skills',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 40,
                      thickness: .5,
                      indent: 30,
                      color: text_400,
                    ),
                  ),
                ],
              ),
              const Gap(5),
              const Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SkillItem(skill: 'React'),
                  SkillItem(skill: 'Javascript'),
                  SkillItem(skill: 'NodeJS'),
                  SkillItem(skill: 'CI/CD'),
                  SkillItem(skill: 'Flutter'),
                ],
              ),
              const Gap(30),

              // Resume & Transcript
              Row(
                children: [
                  Text(
                    'Resume & Transcript',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 40,
                      thickness: .5,
                      indent: 30,
                      color: text_400,
                    ),
                  ),
                ],
              ),
              // Resume
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Resume: ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: '1713367523615-Mock CV.pdf',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontStyle: FontStyle.italic)),
                      ]),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.open_in_browser, size: 30),
                  ),
                ],
              ),
              // Transcript
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Transcript: ',
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: '1713367527862-logo.png',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontStyle: FontStyle.italic)),
                      ]),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.open_in_browser, size: 30),
                  ),
                ],
              ),
              const Gap(40),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary_300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.message_outlined,
                              color: text_50, size: 20),
                          Gap(10),
                          Text(
                            'Message',
                            style: TextStyle(
                              color: text_50,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(30),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Hired offer',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            content: const Text(
                                'Do you really want to send hired offer for student to do this project?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Cancel hire action
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(.75),
                                      ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Perform hire action
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Send',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary_300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.check_box_outlined,
                              color: text_50, size: 20),
                          Gap(10),
                          Text(
                            'Hire',
                            style: TextStyle(
                              color: text_50,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

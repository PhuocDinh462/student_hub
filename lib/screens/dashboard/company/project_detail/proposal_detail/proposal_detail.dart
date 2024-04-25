import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:student_hub/api/services/profile.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/proposal_detail/widgets/skill_item.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:student_hub/widgets/yes_no_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ProposalDetail extends StatelessWidget {
  const ProposalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileService profileService = ProfileService();
    final Proposal proposal = Get.arguments;

    void openResume() async {
      context.loaderOverlay.show();
      profileService.getResumeStudent(proposal.studentId).then((value) async {
        final url = Uri.parse(value);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        context.loaderOverlay.hide();
      });
    }

    void openTranscript() async {
      context.loaderOverlay.show();
      profileService
          .getTranscriptStudent(proposal.studentId)
          .then((value) async {
        final url = Uri.parse(value);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() {
        context.loaderOverlay.hide();
      });
    }

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
                          proposal.studentName,
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
                          proposal.techStack.name,
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
                child: Text(proposal.coverLetter),
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
                children: proposal.educations
                    .map(
                      (education) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(education.schoolName),
                          Text(
                            '${education.startYear} - ${education.endYear}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          const Gap(15),
                        ],
                      ),
                    )
                    .toList(),
              ),
              const Gap(15),

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
                            text: proposal.resume,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontStyle: FontStyle.italic)),
                      ]),
                    ),
                  ),
                  IconButton(
                    onPressed: () => openResume(),
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
                            text: proposal.transcript,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontStyle: FontStyle.italic)),
                      ]),
                    ),
                  ),
                  IconButton(
                    onPressed: () => openTranscript(),
                    icon: const Icon(Icons.open_in_browser, size: 30),
                  ),
                ],
              ),
              const Gap(40),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary_300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          const Icon(Icons.message_outlined, color: text_50)),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return YesNoDialog(
                            title: 'Hired offer',
                            content:
                                'Do you really want to send hired offer for student to do this project?',
                            onYesPressed: () {
                              // Accept proposal
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary_300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.check, color: text_50),
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

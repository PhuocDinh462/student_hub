import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/proposal_detail/widgets/skill_item.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:student_hub/widgets/yes_no_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProposalDetail extends StatefulWidget {
  const ProposalDetail({super.key});

  @override
  createState() => _ProposalDetailState();
}

class _ProposalDetailState extends State<ProposalDetail> {
  final int proposalId = Get.arguments;
  late final Proposal? proposal;
  final ProfileService profileService = ProfileService();
  final ProposalService proposalService = ProposalService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProposal();
  }

  Future<void> getProposal() async {
    isLoading = true;
    proposalService.getProposalById(proposalId).then((value) {
      setState(() => proposal = value);
    }).catchError((e) {
      throw Exception(e);
    }).whenComplete(() {
      isLoading = false;
    });
  }

  void openResume() async {
    context.loaderOverlay.show();
    profileService.getResumeStudent(proposal!.studentId).then((value) async {
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
        .getTranscriptStudent(proposal!.studentId)
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

  void updateStatusFlag(StatusFlag statusFlag) {
    context.loaderOverlay.show();
    proposalService
        .updateProposalStatusFlag(proposal!.id, statusFlag)
        .then((value) {
      setState(() => proposal!.statusFlag = statusFlag);
    }).catchError((e) {
      throw Exception(e);
    }).whenComplete(() {
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
                                proposal!.studentName,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const Gap(5),
                              Text(
                                proposal!.techStack.name,
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
                      child: Text(proposal!.coverLetter),
                    ),
                    const Gap(30),

                    // Educations
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.educations,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
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
                      children: proposal!.educations
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
                          AppLocalizations.of(context)!.skills,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
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
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: proposal!.skillSets
                          .map((skill) => SkillItem(skill: skill.name))
                          .toList(),
                    ),
                    const Gap(30),

                    // Resume & Transcript
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.resume} & ${AppLocalizations.of(context)!.transcript}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
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
                            textDirection: TextDirection.ltr,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.resume}: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              TextSpan(
                                  text: proposal!.resume,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontStyle: FontStyle.italic)),
                            ]),
                          ),
                        ),
                        IconButton(
                          onPressed: proposal!.resume.isEmpty
                              ? null
                              : () => openResume(),
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
                            textDirection: TextDirection.ltr,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.transcript}: ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              TextSpan(
                                  text: proposal!.transcript,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontStyle: FontStyle.italic)),
                            ]),
                          ),
                        ),
                        IconButton(
                          onPressed: proposal!.transcript.isEmpty
                              ? null
                              : () => openTranscript(),
                          icon: const Icon(Icons.open_in_browser, size: 30),
                        ),
                      ],
                    ),
                    const Gap(40),

                    // Action buttons
                    if (proposal!.statusFlag != StatusFlag.hired)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary_300,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Icon(Icons.message_outlined,
                                  color: text_50)),
                          const Gap(20),
                          ElevatedButton(
                            onPressed: proposal!.statusFlag == StatusFlag.offer
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return YesNoDialog(
                                          title: AppLocalizations.of(context)!
                                              .sendHiredOfferTitle,
                                          content: AppLocalizations.of(context)!
                                              .sendHireOfferContent,
                                          onYesPressed: () {
                                            if (projectProvider
                                                    .getCurrentProject!
                                                    .countHired <
                                                projectProvider
                                                    .getCurrentProject!
                                                    .requiredStudents) {
                                              updateStatusFlag(
                                                  StatusFlag.offer);
                                              projectProvider
                                                  .increaseCountHiredCurrentProject();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .sendHireOfferFullStudentError,
                                                    style: const TextStyle(
                                                        color: text_50),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary_300,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: proposal!.statusFlag == StatusFlag.offer
                                ? const Icon(Icons.hourglass_empty)
                                : const Icon(Icons.check, color: text_50),
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

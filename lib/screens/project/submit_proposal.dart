import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ActionProposal {
  submit,
  update,
}

class SubmitProposal extends StatefulWidget {
  const SubmitProposal({
    super.key,
    required this.projectId,
    this.action = ActionProposal.submit,
  });
  final int projectId;
  final ActionProposal action;

  @override
  State<SubmitProposal> createState() => _SubmitProposalState();
}

class _SubmitProposalState extends State<SubmitProposal> {
  final TextEditingController _textController = TextEditingController();
  late ProposalModel? proposalInfo;
  late ActionProposal action;

  @override
  void initState() {
    super.initState();
    action = widget.action;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final proposalSVM =
          Provider.of<ProposalStudentViewModel>(context, listen: false);
      final userInfo = Provider.of<UserProvider>(context, listen: false);

      proposalSVM
          .getProposalByStudentId(userInfo.currentUser!.studentId)
          .then((value) {
        proposalInfo = proposalSVM.proposals.firstWhere(
          (element) => element.projectId == widget.projectId,
          orElse: () => const ProposalModel(),
        );
        _textController.text = proposalInfo!.coverLetter;

        if (proposalInfo?.projectId != -1) {
          if (widget.action == ActionProposal.submit) {
            MySnackBar.showSnackBar(
              context,
              AppLocalizations.of(context)!.notifSubmittedProposal,
              'Help',
              ContentType.help,
            );
          }
          setState(() {
            action = ActionProposal.update;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void hanldeSubmitProposal(
      ProposalStudentViewModel psm, BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final ProposalModel pm = ProposalModel(
        id: proposalInfo!.id,
        projectId: widget.projectId,
        coverLetter: _textController.text,
        studentId: userProvider.currentUser!.studentId ?? -1);

    if (action == ActionProposal.submit) {
      psm.createProposalStudent(pm).then((value) {
        handleAfterLoading(psm, context);
      });
    } else {
      psm.updateProposalStudent(pm).then((value) {
        handleAfterLoading(psm, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.secondaryContainer,
        body: Consumer<ProposalStudentViewModel>(
            builder: (context, proposalStudentViewModel, child) {
          return proposalStudentViewModel.loading
              ? const Center(
                  child: Column(children: [
                    Gap(30),
                    CircularProgressIndicator(),
                  ]),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(minHeight: deviceSize.height),
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DisplayText(
                                text: AppLocalizations.of(context)!.coverLetter,
                                style: textTheme.headlineLarge!),
                            const Gap(20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: colorScheme.onSecondary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: CommonTextField(
                                title: AppLocalizations.of(context)!
                                    .descriptionLetter,
                                hintText:
                                    AppLocalizations.of(context)!.yourAnwser,
                                maxLines: 20,
                                titleStyle: textTheme.labelSmall!
                                    .copyWith(color: primary_300),
                                controller: _textController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!Provider.of<GlobalProvider>(context, listen: true)
                        .isFocus)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: deviceSize.width,
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 20, bottom: 30),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  style: buttonSecondary,
                                  onPressed: () {
                                    proposalStudentViewModel.setProposals([]);
                                    Get.back();
                                  },
                                  child: DisplayText(
                                    text: AppLocalizations.of(context)!.cancel,
                                    style: textTheme.labelLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                              const Gap(10),
                              ElevatedButton(
                                  style: buttonPrimary,
                                  onPressed: () {
                                    hanldeSubmitProposal(
                                        proposalStudentViewModel, context);
                                  },
                                  child: DisplayText(
                                    text: action == ActionProposal.submit
                                        ? AppLocalizations.of(context)!
                                            .submitProposal
                                        : AppLocalizations.of(context)!
                                            .updateProposal,
                                    style: textTheme.labelLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )
                  ]));
        }));
  }

  void handleAfterLoading(
      ProposalStudentViewModel proposalStudentViewModel, BuildContext context) {
    if (proposalStudentViewModel.successMessage != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (action == ActionProposal.submit) {
          Get.toNamed(StudentRoutes.nav, arguments: {
            'index': 0,
            'message':
                AppLocalizations.of(context)!.notifSuccessCreatedProposal,
            'messageType': ContentType.success,
          });
        } else {
          MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.notifSuccessUpdateProposal,
            'Successful',
            ContentType.success,
          );
        }

        proposalStudentViewModel.successMessage = '';

        setState(() {
          action = ActionProposal.update;
        });
      });
    } else if (proposalStudentViewModel.errorMessage != '') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.notifFail,
          'Failed',
          ContentType.failure,
        );
        proposalStudentViewModel.errorMessage = '';
      });
    }
  }
}

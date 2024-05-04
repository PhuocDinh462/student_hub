import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/common_dropdown_menu.dart';
import 'package:student_hub/widgets/project_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllProjectStudent extends StatefulWidget {
  const AllProjectStudent({
    super.key,
  });

  @override
  State<AllProjectStudent> createState() => _AllProjectStudentState();
}

class _AllProjectStudentState extends State<AllProjectStudent> {
  void handleOpenProjectDetails(
      Project project, ProjectDetailsView view) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (ctx) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ProjectDetails(
              project: project,
              viewType: view,
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final proposalSVM =
          Provider.of<ProposalStudentViewModel>(context, listen: false);
      final userInfo = Provider.of<UserProvider>(context, listen: false);

      proposalSVM.getProposal(userInfo.currentUser!.studentId, 0);
      proposalSVM.getProposal(userInfo.currentUser!.studentId, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProposalStudentViewModel>(builder: (context, psvm, child) {
      return psvm.loading
          ? const Column(children: [
              Gap(30),
              CircularProgressIndicator(),
            ])
          : Column(
              children: [
                CommonDropdownMenu(
                  id: 1,
                  labelText:
                      '${AppLocalizations.of(context)!.activeProposal} (${psvm.proposalActive.length})',
                  proposals: psvm.proposalActive,
                  view: ProjectDetailsView.viewActiveProposal,
                  actionCard: (project) {
                    handleOpenProjectDetails(
                        project, ProjectDetailsView.viewActiveProposal);
                  },
                ),
                const Gap(20),
                CommonDropdownMenu(
                  id: 2,
                  labelText:
                      '${AppLocalizations.of(context)!.submitedProposal} (${psvm.proposalSubmited.length})',
                  proposals: psvm.proposalSubmited,
                  view: ProjectDetailsView.viewProposal,
                  actionCard: (project) {
                    handleOpenProjectDetails(
                        project, ProjectDetailsView.viewProposal);
                  },
                ),
              ],
            );
    });
  }
}

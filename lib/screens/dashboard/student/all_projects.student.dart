import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/common_dropdown_menu.dart';

class AllProjectStudent extends StatefulWidget {
  const AllProjectStudent({
    super.key,
  });

  @override
  State<AllProjectStudent> createState() => _AllProjectStudentState();
}

class _AllProjectStudentState extends State<AllProjectStudent> {
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
      if (psvm.loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
      return Column(
        children: [
          CommonDropdownMenu(
            id: 1,
            labelText: 'Active proposal (${psvm.proposalActive.length})',
            proposals: psvm.proposalActive,
          ),
          const Gap(20),
          CommonDropdownMenu(
            id: 2,
            labelText: 'Submitted proposal (${psvm.proposalSubmited.length})',
            proposals: psvm.proposalSubmited,
          ),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/dashboard/student/widgets/dashboard.widgets.dart';
import 'package:student_hub/utils/empty.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';

class ListProposalScreen extends StatefulWidget {
  const ListProposalScreen({super.key});

  @override
  State<ListProposalScreen> createState() => _ListProposalScreenState();
}

class _ListProposalScreenState extends State<ListProposalScreen> {
  late IndexPageProvider indexPageProvider;
  late ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    indexPageProvider = Provider.of<IndexPageProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final proposalSVM =
          Provider.of<ProposalStudentViewModel>(context, listen: false);
      final userInfo = Provider.of<UserProvider>(context, listen: false);

      proposalSVM.getProjectWorkingOrArchived(
          userInfo.currentUser!.studentId, indexPageProvider.getIndexDBStudent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProposalStudentViewModel>(builder: (context, psvm, child) {
      if (psvm.loading) {
        return const Column(children: [
          Gap(30),
          CircularProgressIndicator(),
        ]);
      } else {
        if (psvm.proposals.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: psvm.proposals.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                return CardInfoProposal(
                  proposal: psvm.proposals[index],
                  // action: widget.actionCard,
                  view: ProjectDetailsView.viewProjectProposal,
                );
              },
            ),
          );
        } else {
          return Center(
            child: Empty(
                imgPath: 'assets/images/Empty.png',
                text: indexPageProvider.getIndexDBStudent == 1
                    ? 'No project is working'
                    : 'No project is archived'),
          );
        }
      }
    });
  }
}

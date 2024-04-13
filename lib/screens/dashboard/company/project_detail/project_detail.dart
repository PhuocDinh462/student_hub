import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/proposal.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/project_info.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/proposal_item.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({super.key});

  @override
  createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  final ProposalService proposalService = ProposalService();
  List<Proposal> _proposalList = [];

  void fetchProposal(int projectId) async {
    await proposalService.getProposal(projectId).then((value) {
      setState(() => _proposalList = value);
    }).catchError((e) {
      throw Exception(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);
    fetchProposal(projectProvider.getCurrentProject!.id);

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            dividerColor: Theme.of(context).brightness == Brightness.dark
                ? text_800
                : text_200,
            tabs: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Tab(
                  child: Icon(Icons.info,
                      color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Tab(
                  child: Icon(Icons.message,
                      color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Tab(
                  child: Icon(Icons.description,
                      color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Tab(
                  child: Icon(Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Info
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: ProjectInfo(),
                  ),
                  // Message
                  const Center(
                    child: Text('Message'),
                  ),
                  // Proposals
                  _proposalList
                          .where((item) => item.statusFlag == StatusFlag.offer)
                          .isEmpty
                      ? const Center(
                          child: Text('No proposal yet'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const Gap(10),
                              Column(
                                children: _proposalList
                                    .where((item) =>
                                        item.statusFlag == StatusFlag.offer)
                                    .map(
                                      (item) => Column(
                                        children: [
                                          ProposalItem(
                                            proposal: item,
                                          ),
                                          const Gap(10),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                  // Hired
                  _proposalList
                          .where((item) => item.statusFlag == StatusFlag.hired)
                          .isEmpty
                      ? const Center(
                          child: Text('No hired student yet'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const Gap(10),
                              Column(
                                children: _proposalList
                                    .where((item) =>
                                        item.statusFlag == StatusFlag.hired)
                                    .map(
                                      (item) => Column(
                                        children: [
                                          ProposalItem(
                                            proposal: item,
                                          ),
                                          const Gap(10),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

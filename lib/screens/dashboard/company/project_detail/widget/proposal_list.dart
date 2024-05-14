import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/proposal.service.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/models/proposal.model.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/proposal_item.dart';
import 'package:student_hub/utils/empty.dart';

class ProposalList extends StatefulWidget {
  const ProposalList({super.key, required this.statusFlags});
  final Set<StatusFlag> statusFlags;

  @override
  createState() => _ProposalListState();
}

class _ProposalListState extends State<ProposalList> {
  final ProposalService proposalService = ProposalService();
  bool _isLoading = false;
  final List<Proposal> _proposalList = [];

  @override
  void initState() {
    fetchProposal();
    super.initState();
  }

  void fetchProposal() async {
    setState(() => _isLoading = true);
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    await proposalService
        .getProposalByProjectId(projectProvider.getCurrentProject!.id, {
      'statusFlag': widget.statusFlags.map((e) => e.index).join(','),
    }).then((value) {
      setState(() => _proposalList.addAll(value));
    }).catchError((e) {
      throw Exception(e);
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : _proposalList.isEmpty
            ? const Center(
                child: Empty(),
              )
            : ListView.builder(
                itemCount: _proposalList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        10, 10, 10, index == _proposalList.length - 1 ? 10 : 0),
                    child: ProposalItem(
                      proposal: _proposalList[index],
                    ),
                  );
                },
              );
  }
}

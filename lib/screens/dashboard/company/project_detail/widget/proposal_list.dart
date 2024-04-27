import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/proposal.service.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/proposal_item.dart';
import 'package:student_hub/utils/empty.dart';

class ProposalList extends StatefulWidget {
  const ProposalList({super.key, required this.statusFlag});
  final StatusFlag statusFlag;

  @override
  createState() => _ProposalListState();
}

class _ProposalListState extends State<ProposalList> {
  final ProposalService proposalService = ProposalService();
  bool _isLoading = false;
  List<Proposal> _proposalList = [];

  @override
  void initState() {
    fetchProposal();
    super.initState();
  }

  void fetchProposal() async {
    setState(() => _isLoading = true);
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    await proposalService.getProposal(projectProvider.getCurrentProject!.id, {
      'statusFlag': widget.statusFlag.index.toString(),
    }).then((value) {
      setState(() => _proposalList = value);
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
                child: Empty(
                    imgPath: 'assets/images/Empty.png',
                    text: 'No data available'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(10),
                    Column(
                      children: _proposalList
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
              );
  }
}

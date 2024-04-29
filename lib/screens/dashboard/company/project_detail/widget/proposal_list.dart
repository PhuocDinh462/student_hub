import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/proposal.service.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:student_hub/models/proposal.model.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/proposal_item.dart';
import 'package:student_hub/utils/empty.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    await proposalService.getProposal(projectProvider.getCurrentProject!.id, {
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
            ? Center(
                child:
                    Empty(text: AppLocalizations.of(context)!.noDataAvailable),
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

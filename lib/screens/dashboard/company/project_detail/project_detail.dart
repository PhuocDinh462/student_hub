import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/proposal.model.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/screens/chat/message_list.screen.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/project_info.dart';
import 'widget/proposal_list.dart';

class ProjectDetail extends StatelessWidget {
  const ProjectDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

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
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Info
                const ProjectInfo(),
                // Message
                MessageListScreen(
                    projectId: projectProvider.getCurrentProject!.id),
                // Proposals
                const ProposalList(statusFlags: <StatusFlag>{
                  StatusFlag.waiting,
                  StatusFlag.active,
                  StatusFlag.offer,
                }),
                // Hired
                const ProposalList(statusFlags: <StatusFlag>{
                  StatusFlag.hired,
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

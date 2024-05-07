import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/proposal.model.dart';
import 'package:student_hub/screens/dashboard/company/project_detail/widget/project_info.dart';
import 'widget/proposal_list.dart';

class ProjectDetail extends StatelessWidget {
  const ProjectDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              // Padding(
              //   padding: const EdgeInsets.only(top: 2.0),
              //   child: Tab(
              //     child: Icon(Icons.message,
              //         color: Theme.of(context).colorScheme.primary, size: 24),
              //   ),
              // ),
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
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Info
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: ProjectInfo(),
                  ),
                  // Message
                  // Center(
                  //   child: Text('Message'),
                  // ),
                  // Proposals
                  ProposalList(statusFlags: <StatusFlag>{
                    StatusFlag.waiting,
                    StatusFlag.active,
                    StatusFlag.offer,
                  }),
                  // Hired
                  ProposalList(statusFlags: <StatusFlag>{
                    StatusFlag.hired,
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

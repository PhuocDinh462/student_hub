import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/dashboard/project_detail/widget/proposal_item.dart';

class ProjectDetail extends StatelessWidget {
  const ProjectDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(Icons.description,
                      color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
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
                  child: Icon(Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary, size: 24),
                ),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                // Proposals
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(10),
                        ProposalItem(),
                        Gap(10),
                        ProposalItem(),
                        Gap(10),
                        ProposalItem(),
                        Gap(10),
                        ProposalItem(),
                        Gap(10),
                        ProposalItem(),
                        Gap(10),
                        ProposalItem(),
                        Gap(10),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text('Detail'),
                ),
                Center(
                  child: Text('Message'),
                ),
                Center(
                  child: Text('Hired'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

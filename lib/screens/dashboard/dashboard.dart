import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/post_job_provider.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/screens/dashboard/widgets/project_item.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final PostJobProvider postJobProvider =
        Provider.of<PostJobProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postJobProvider.clear();
          Navigator.pushNamed(context, AppRoutes.postJob);
        },
        foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? primary_200
            : primary_300,
        child: const Icon(Icons.add),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              dividerColor: Theme.of(context).brightness == Brightness.dark
                  ? text_800
                  : text_200,
              tabs: const [
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Tab(
                    child: Text(
                      'All projects',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Tab(
                    child: Text(
                      'Working',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Tab(
                    child: Text(
                      'Archived',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // All projects
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gap(10),
                          ProjectItem(),
                          Gap(10),
                          ProjectItem(),
                          Gap(10),
                          ProjectItem(),
                          Gap(10),
                          ProjectItem(),
                          Gap(10),
                          ProjectItem(),
                          Gap(10),
                          ProjectItem(),
                          Gap(85),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Working'),
                  ),
                  Center(
                    child: Text('Archived'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
// import 'package:student_hub/api/services/project.services.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/screens/dashboard/company/widgets/project_item.dart';
import 'package:student_hub/utils/custom_dio.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectProvider postJobProvider =
        Provider.of<ProjectProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    // final ProjectService projectService = ProjectService();

    void fetchData(ProjectProvider postJobProvider) async {
      //   await projectService.getProject(userProvider.currentUser?.companyId).then((value) {
      //     postJobProvider.setProjectList = value.data['result']
      //         .map<Project>((item) => Project.fromMap(item))
      //         .toList();
      //   }).catchError((e) {
      //     throw Exception(e);
      //   });

      await privateDio
          .get('/project/company/${userProvider.currentUser?.companyId}')
          .then((value) {
        postJobProvider.setProjectList = value.data['result']
            .map<Project>((item) => Project.fromMap(item))
            .toList();
      }).catchError((e) {
        throw Exception(e);
      });
    }

    fetchData(postJobProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postJobProvider.clear();
          Navigator.pushNamed(context, CompanyRoutes.postProject);
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
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // All projects
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Gap(10),
                          Column(
                            children: postJobProvider.getProjectList
                                .map((item) => Column(
                                      children: [
                                        ProjectItem(
                                          project: item,
                                        ),
                                        const Gap(10),
                                      ],
                                    ))
                                .toList(),
                          ),
                          const Gap(85),
                        ],
                      ),
                    ),
                  ),
                  const Center(
                    child: Text('Working'),
                  ),
                  const Center(
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

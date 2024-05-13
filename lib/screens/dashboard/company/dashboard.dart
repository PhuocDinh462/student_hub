import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/project.company.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/company_route.dart';
import 'widgets/project_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardCompany extends StatefulWidget {
  const DashboardCompany({super.key});

  @override
  createState() => _DashboardCompanyState();
}

class _DashboardCompanyState extends State<DashboardCompany> {
  bool _isLoading = false;
  bool _showPostProjectBtn = true;
  final ProjectService projectService = ProjectService();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    setState(() => _isLoading = true);
    await projectService
        .getProject(userProvider.currentUser?.companyId)
        .then((value) {
      projectProvider.setProjectList = value;
    }).catchError((e) {
      throw Exception(e);
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return userProvider.currentUser?.companyId == null
        ? const Center(
            child: Text(
              'Please update your company profile',
              textDirection: TextDirection.ltr,
            ),
          )
        : Scaffold(
            floatingActionButton: _showPostProjectBtn
                ? FloatingActionButton(
                    onPressed: () {
                      projectProvider.clear();
                      Navigator.pushNamed(context, CompanyRoutes.postProject);
                    },
                    foregroundColor: theme.colorScheme.secondaryContainer,
                    backgroundColor: theme.brightness == Brightness.dark
                        ? primary_200
                        : primary_300,
                    child: Icon(
                      Icons.add,
                      color: theme.brightness == Brightness.dark
                          ? text_700
                          : text_50,
                    ),
                  )
                : null,
            body: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    onTap: (index) {
                      setState(() => _showPostProjectBtn = index == 0);
                    },
                    dividerColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? text_800
                            : text_200,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Tab(
                          child: Text(
                            AppLocalizations.of(context)!.newType,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Tab(
                          child: Text(
                            AppLocalizations.of(context)!.working,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Tab(
                          child: Text(
                            AppLocalizations.of(context)!.archived,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              // New
                              ProjectList(typeFlag: TypeFlag.newType),
                              // Working
                              ProjectList(typeFlag: TypeFlag.working),
                              // Archived
                              ProjectList(typeFlag: TypeFlag.archived),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}

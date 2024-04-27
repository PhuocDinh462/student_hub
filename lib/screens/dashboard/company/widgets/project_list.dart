import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/project.company.service.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/dashboard/company/widgets/project_item.dart';
import 'package:student_hub/utils/empty.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key, this.typeFlag});
  final TypeFlag? typeFlag;

  @override
  createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  bool _isLoading = false;
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
        .getProject(
      userProvider.currentUser?.companyId,
      widget.typeFlag != null
          ? {'typeFlag': widget.typeFlag?.index.toString()}
          : null,
    )
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
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : projectProvider.getProjectList
                .where((element) => widget.typeFlag != null
                    ? element.typeFlag == widget.typeFlag
                    : true)
                .isEmpty
            ? const Center(
                child: Empty(
                    imgPath: 'assets/images/Empty.png',
                    text: 'No data available'),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(10),
                      Column(
                        children: projectProvider.getProjectList
                            .where((element) => widget.typeFlag != null
                                ? element.typeFlag == widget.typeFlag
                                : true)
                            .map(
                              (item) => Column(
                                children: [
                                  ProjectItem(
                                    project: item,
                                  ),
                                  const Gap(10),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      if (widget.typeFlag == TypeFlag.newType) const Gap(85),
                    ],
                  ),
                ),
              );
  }
}

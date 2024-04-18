import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/dashboard/student/student.dart';

List<String> headerTitle = ['All projects', 'Working', 'Archived'];

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({super.key});

  @override
  State<DashboardStudent> createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  PageController pageController = PageController();
  late IndexPageProvider indexPageProvider;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    indexPageProvider = Provider.of<IndexPageProvider>(context, listen: false);
    indexPageProvider.addListener(_handleIndexPageChange);
  }

  @override
  void dispose() {
    indexPageProvider.removeListener(_handleIndexPageChange);

    pageController.dispose();
    super.dispose();
  }

  void _handleIndexPageChange() {
    final int indexPage = indexPageProvider.getIndexDBStudent;

    pageController.animateToPage(
      indexPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> pages = [const AllProjectStudent(), const WorkingStudent()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderStudentDashboard(
          headerTitle: headerTitle,
          title: 'Your project',
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: PageView.builder(
                itemCount: pages.length,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return pages[index];
                }),
          ),
        ),
      ],
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    Provider.of<IndexPageProvider>(context, listen: false)
        .addListener(_handleIndexPageChange);
  }

  @override
  void dispose() {
    Provider.of<IndexPageProvider>(context, listen: false)
        .removeListener(_handleIndexPageChange);
    pageController.dispose();
    super.dispose();
  }

  void _handleIndexPageChange() {
    var indexPage = Provider.of<IndexPageProvider>(context, listen: false)
        .getIndexDBStudent;
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
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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

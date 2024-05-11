import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/dashboard/student/student.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({super.key});

  @override
  State<DashboardStudent> createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  PageController pageController = PageController();
  List<String> headerTitle = [];
  late IndexPageProvider indexPageProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    headerTitle.add(AppLocalizations.of(context)!.all);
    headerTitle.add(AppLocalizations.of(context)!.working);
    headerTitle.add(AppLocalizations.of(context)!.archived);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    indexPageProvider = Provider.of<IndexPageProvider>(context, listen: false);
    indexPageProvider.addListener(_handleIndexPageChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      indexPageProvider.setIndexDBStudent(0);
      _handleIndexPageChange();
    });
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

  List<Widget> pages = [
    const AllProjectStudent(),
    const ListProposalScreen(),
    const ListProposalScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderStudentDashboard(
          headerTitle: headerTitle,
          title: AppLocalizations.of(context)!.yourProject,
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

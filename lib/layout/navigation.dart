import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/user.provider.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:student_hub/screens/chat/chat.dart';
import 'package:student_hub/screens/dashboard/company/dashboard.dart';
import 'package:student_hub/screens/dashboard/student/dashboard.student.dart';
import 'package:student_hub/screens/interviews/interviews.dart';
import 'package:student_hub/screens/project/projects.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Navigation extends StatefulWidget {
  const Navigation(
      {super.key,
      required this.currentScreenIndex,
      required this.message,
      required this.messageType});
  final int? currentScreenIndex;
  final String? message;
  final ContentType? messageType;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int currentScreenIndex;

  @override
  void initState() {
    super.initState();
    currentScreenIndex = widget.currentScreenIndex ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.messageType != null) {
        String title = widget.messageType == ContentType.failure
            ? 'Something went wrong'
            : widget.messageType == ContentType.success
                ? 'Success'
                : widget.messageType == ContentType.help
                    ? 'Information'
                    : 'Warning';

        MySnackBar.showSnackBar(
          context,
          widget.message ?? '',
          title,
          ContentType.success,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) => setState(() => currentScreenIndex = index),
          selectedItemColor: Theme.of(context).brightness == Brightness.light
              ? primary_300
              : primary_200,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Theme.of(context).brightness == Brightness.light
              ? text_400
              : text_500,
          currentIndex: currentScreenIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.task,
              ),
              label: AppLocalizations.of(context)!.projects,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.dashboard,
              ),
              label: AppLocalizations.of(context)!.dashboard,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.message,
              ),
              label: AppLocalizations.of(context)!.messages,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.notifications,
              ),
              label: AppLocalizations.of(context)!.alerts,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.video_call_rounded,
              ),
              label: AppLocalizations.of(context)!.interviews,
            ),
          ],
        ),
        body: <Widget>[
          const Projects(),
          userProvider.currentUser?.currentRole == Role.student
              ? const DashboardStudent()
              : const DashboardCompany(),
          const MessageListScreen(),
          const AlertScreen(),
          const Interviews(),
        ][currentScreenIndex]);
  }
}

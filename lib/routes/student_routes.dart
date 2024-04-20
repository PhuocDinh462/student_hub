import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:student_hub/screens/dashboard/student/dashboard.student.dart';
import 'package:student_hub/screens/project/submit_proposal.dart';

import 'package:student_hub/screens/screens.dart';

class StudentRoutes {
  static const String nav = '/';
  static const String changePassword = '/profile/change_password';
  static const String dashboardStudent = '/dashboard-student';
  static const String welcomeCompany = '/welcome-company';
  static const String profileCompany = '/account-company/profile';
  static const String profileStudentStepOne = '/account-student/profile-1';
  static const String profileStudentStepTwo =
      '/account-student/profile-1/profile-2';
  static const String profileStudentStepThree =
      '/account-student/profile-1/profile-2/profile-3';
  static const String projects = '/projects';
  static const String projectsSaved = '/projects/saved';
  static const String submitProposalStudent = '/projects/submit-student';
  static const String messageList = '/chat/message-list';
  static const String videoCall = '/chat/video-call';
  static const String alerts = '/alerts';
  static const String chatScreen = '/chat-screen';
  static const String account = '/account';
  static const String settings = '/account/settings';
  static const String languages = '/account/settings/languages';

  static Map<String, WidgetBuilder> routes = {
    nav: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final index = int.parse(args?['index'] as String? ?? '0');

      return AccountHeader(
        title: 'Student Hub',
        body: Navigation(currentScreenIndex: index),
        resizeToAvoidBottomInset: false,
      );
    },
    changePassword: (context) =>
        const AccountHeader(title: 'Student Hub', body: ChangePassword()),
    dashboardStudent: (context) =>
        const AccountHeader(title: 'Student Hub', body: DashboardStudent()),
    welcomeCompany: (context) =>
        const AccountHeader(title: 'Welcome', body: WelcomeCompany()),
    profileCompany: (context) =>
        const AccountHeader(title: 'Profile', body: ProfileCompanyInput()),
    profileStudentStepOne: (context) =>
        const AccountHeader(title: 'Profile', body: ProfileStudentStepOne()),
    profileStudentStepTwo: (context) =>
        const AccountHeader(title: 'Profile', body: ProfileStudentStepTwo()),
    profileStudentStepThree: (context) =>
        const AccountHeader(title: 'Profile', body: ProfileStudentStepThree()),
    projectsSaved: (context) =>
        const AccountHeader(title: 'Saved Projects', body: ProjectsSaved()),
    projects: (context) =>
        const AccountHeader(title: 'Student Hub', body: Projects()),
    submitProposalStudent: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final int projectId = args?['projectId'] ?? 0;

      return AccountHeader(
          title: 'Apply Now',
          body: SubmitProposal(
            projectId: projectId,
          ));
    },
    messageList: (context) =>
        const AccountHeader(title: 'Student Hub', body: MessageListScreen()),
    videoCall: (context) =>
        const AccountHeader(title: 'Video Call', body: VideoCallScreen()),
    alerts: (context) =>
        const AccountHeader(title: 'Student Hub', body: AlertScreen()),
    chatScreen: (context) => const ChatRoomScreen(),
    account: (context) =>
        const AccountHeader(title: 'Account', body: Account()),
    settings: (context) =>
        const AccountHeader(title: 'Settings', body: Settings()),
    languages: (context) =>
        const AccountHeader(title: 'Languages', body: Languages()),
  };
}

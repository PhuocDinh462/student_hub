import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:student_hub/screens/dashboard/student/dashboard.student.dart';
import 'package:student_hub/screens/project/submit_proposal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  static const String videoConference = '/video-conference';

  static Map<String, WidgetBuilder> routes = {
    nav: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final index = args?['index'];
      final message = args?['message'];
      final messageType = args?['messageType'];

      return AccountHeader(
        title: 'Student Hub',
        body: Navigation(
          currentScreenIndex: index,
          message: message,
          messageType: messageType,
        ),
        resizeToAvoidBottomInset: false,
      );
    },
    changePassword: (context) =>
        const AccountHeader(title: 'Student Hub', body: ChangePassword()),
    dashboardStudent: (context) =>
        const AccountHeader(title: 'Student Hub', body: DashboardStudent()),
    welcomeCompany: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final appLocal = args?['appLocal'];
      return AccountHeader(
          title: 'Welcome',
          body: WelcomeCompany(
            appLocal: appLocal,
          ));
    },
    profileCompany: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.profile,
        body: const ProfileCompanyInput()),
    profileStudentStepOne: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.profile,
        body: const ProfileStudentStepOne()),
    profileStudentStepTwo: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.profile,
        body: const ProfileStudentStepTwo()),
    profileStudentStepThree: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.profile,
        body: const ProfileStudentStepThree()),
    projectsSaved: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.savedProject,
        body: const ProjectsSaved()),
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
    videoCall: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.videoCall,
        body: const VideoCallScreen()),
    alerts: (context) =>
        const AccountHeader(title: 'Student Hub', body: AlertScreen()),
    chatScreen: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      final ProjectModel project = args?['project'];
      final UserModel sender = args?['sender'];
      final UserModel receiver = args?['receiver'];

      return ChatRoomScreen(
          project: project, receiver: receiver, sender: sender);
    },
    account: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.account(''),
        body: const Account()),
    settings: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.settings, body: const Settings()),
    languages: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.language(''),
        body: const Languages()),
    videoConference: (context) => const VideoConference(),
  };
}

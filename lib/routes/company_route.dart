import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/screens/screens.dart';

class CompanyRoutes {
  static const String nav = '/';
  static const String changePassword = '/profile/change_password';
  static const String welcomeCompany = '/welcome-company';
  static const String profileCompany = '/account-company/profile';
  static const String profileStudentStepOne = '/account-student/profile-1';
  static const String profileStudentStepTwo =
      '/account-student/profile-1/profile-2';
  static const String profileStudentStepThree =
      '/account-student/profile-1/profile-2/profile-3';
  static const String messageList = '/chat/message-list';
  static const String videoCall = '/chat/video-call';
  static const String alerts = '/alerts';
  static const String chatScreen = '/chat-screen';
  static const String account = '/account';
  static const String settings = '/account/settings';
  static const String languages = '/account/settings/languages';
  static const String postProject = '/post-project';
  static const String projectDetail = '/project-detail';
  static const String proposalDetail = '/project-detail/proposal-detail';
  static const String editProject = '/edit-project';
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
      final UserModel user = args?['user'];
      final UserModel otherUser = args?['otherUser'];

      return ChatRoomScreen(
        project: project,
        user: user,
        otherUser: otherUser,
      );
    },
    account: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.account(''),
        body: const Account()),
    settings: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.settings, body: const Settings()),
    languages: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.language(''),
        body: const Languages()),
    postProject: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.postProject,
        body: const PostProject()),
    projectDetail: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.projectDetail,
        body: const ProjectDetail()),
    proposalDetail: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.proposalDetail,
        body: const ProposalDetail()),
    editProject: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.editProject,
        body: const EditProject()),
    videoConference: (context) => const VideoConference(),
  };
}

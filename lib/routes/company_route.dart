import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/account/account.dart';
import 'package:student_hub/screens/account/change_password.dart';
import 'package:student_hub/screens/account/languages.dart';
import 'package:student_hub/screens/account/settings.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:student_hub/screens/chat/chat_room_screen.dart';
import 'package:student_hub/screens/chat/message_list.screen.dart';
import 'package:student_hub/screens/chat/video_call.screen.dart';
import 'package:student_hub/screens/dashboard/project_detail/project_detail.dart';
import 'package:student_hub/screens/post_job/post_job.dart';
import 'package:student_hub/screens/profile/company/profile.company.dart';
import 'package:student_hub/screens/profile/company/welcome.company.dart';

class CompanyRoutes {
  static const String nav = '/';
  static const String changePassword = '/profile/change_password';
  static const String welcomeCompany = '/welcome-company';
  static const String profileCompany = '/account-company/profile';
  static const String messageList = '/chat/message-list';
  static const String videoCall = '/chat/video-call';
  static const String alerts = '/alerts';
  static const String chatScreen = '/chat-screen';
  static const String account = '/account';
  static const String settings = '/account/settings';
  static const String languages = '/account/settings/languages';
  static const String postJob = '/post-job';
  static const String projectDetail = 'nav/project-detail';

  static Map<String, WidgetBuilder> routes = {
    nav: (context) => const AccountHeader(
          title: 'Student Hub',
          body: Navigation(),
          resizeToAvoidBottomInset: false,
        ),
    changePassword: (context) =>
        const AccountHeader(title: 'Student Hub', body: ChangePassword()),
    welcomeCompany: (context) =>
        const AccountHeader(title: 'Student Hub', body: WelcomeCompany()),
    profileCompany: (context) =>
        const AccountHeader(title: 'Student Hub', body: ProfileCompanyInput()),
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
    postJob: (context) =>
        const AccountHeader(title: 'Post Job', body: PostJob()),
    projectDetail: (context) =>
        const AccountHeader(title: 'Project Detail', body: ProjectDetail()),
  };
}

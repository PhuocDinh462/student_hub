import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:student_hub/screens/chat/chat_room_screen.dart';
import 'package:student_hub/screens/dashboard/student/dashboard.student.dart';
import 'package:student_hub/screens/project/projects.dart';
import 'package:student_hub/screens/project/projects_saved.dart';

import 'package:student_hub/screens/screens.dart';

class StudentRoutes {
  static const String nav = '/';
  static const String changePassword = '/profile/change_password';
  static const String dashboardStudent = '/dashboard-student';
  static const String profileStudentStepOne = '/account-student/profile-1';
  static const String profileStudentStepTwo =
      '/account-student/profile-1/profile-2';
  static const String profileStudentStepThree =
      '/account-student/profile-1/profile-2/profile-3';
  static const String projects = '/projects';
  static const String projectsSaved = '/projects/saved';
  static const String messageList = '/chat/message-list';
  static const String videoCall = '/chat/video-call';
  static const String alerts = '/alerts';
  static const String chatScreen = '/chat-screen';
  static const String account = '/account';
  static const String settings = '/account/settings';
  static const String languages = '/account/settings/languages';

  static Map<String, WidgetBuilder> routes = {
    nav: (context) => const AccountHeader(
          title: 'Student Hub',
          body: Navigation(),
          resizeToAvoidBottomInset: false,
        ),
    changePassword: (context) =>
        const AccountHeader(title: 'Student Hub', body: ChangePassword()),
    dashboardStudent: (context) =>
        const AccountHeader(title: 'Student Hub', body: DashboardStudent()),
    profileStudentStepOne: (context) => const AccountHeader(
        title: 'Student Hub', body: ProfileStudentStepOne()),
    profileStudentStepTwo: (context) => const AccountHeader(
        title: 'Student Hub', body: ProfileStudentStepTwo()),
    profileStudentStepThree: (context) => const AccountHeader(
        title: 'Student Hub', body: ProfileStudentStepThree()),
    projectsSaved: (context) =>
        const AccountHeader(title: 'Saved Projects', body: ProjectsSaved()),
    projects: (context) =>
        const AccountHeader(title: 'Student Hub', body: Projects()),
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

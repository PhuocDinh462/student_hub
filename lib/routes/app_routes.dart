import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/Authentication/authentication.dart';
import 'package:student_hub/screens/account/languages.dart';
import 'package:student_hub/screens/authentication/reset_password.dart';
import 'package:student_hub/screens/account/change_password.dart';
import 'package:student_hub/screens/authentication/create_account_company.dart';
import 'package:student_hub/screens/authentication/create_account_student.dart';
import 'package:student_hub/screens/authentication/forgot_password.dart';
import 'package:student_hub/screens/authentication/login.dart';
import 'package:student_hub/screens/authentication/sign_up_option.dart';
import 'package:student_hub/screens/authentication/verify_code.dart';
import 'package:student_hub/screens/chat/chat_room_screen.dart';
import 'package:student_hub/screens/home/Home.dart';
import 'package:student_hub/screens/post_job/post_job.dart';
import 'package:student_hub/screens/profile/profile.dart';
import 'package:student_hub/screens/profile/profile_input.dart';
import 'package:student_hub/screens/projects/projects.dart';
import 'package:student_hub/screens/projects/projects_saved.dart';
import 'package:student_hub/screens/welcome/welcome.dart';
import 'package:student_hub/screens/account/account.dart';
import 'package:student_hub/screens/account/settings.dart';

class AppRoutes {
  static const String nav = '/';
  static const String home = '/home';
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot_password';
  static const String verifyCode = '/auth/verify_code';
  static const String createAccountCompany = '/auth/create_account_company';
  static const String createAccountStudent = '/auth/create_account_student';
  static const String signUpOption = '/auth/sign_up';
  static const String resetPassword = '/auth/reset_password';
  static const String profile = '/profile';
  static const String profileNoInfo = '/profile/no-info';
  static const String changePassword = '/profile/change_password';
  static const String projects = '/projects';
  static const String projectsSaved = '/projects/saved';
  static const String welcome = '/welcome';
  static const String account = '/account';
  static const String settings = '/account/settings';
  static const String languages = '/account/settings/languages';
  static const String postJob = '/post_job';

  static const String chatScreen = '/chat-screen';

  static Map<String, WidgetBuilder> routes = {
    nav: (context) => const AccountHeader(
          title: 'Student Hub',
          body: Navigation(),
          resizeToAvoidBottomInset: false,
        ),
    home: (context) => const AccountHeader(title: 'Home', body: Home()),
    auth: (context) => const Authentication(),
    login: (context) => Login(),
    forgotPassword: (context) => const ForgotPassword(),
    verifyCode: (context) => const VerifyCode(),
    createAccountCompany: (context) => const CreateAccountCompany(),
    createAccountStudent: (context) => const CreateAccountStudent(),
    signUpOption: (context) => const SignUpOption(),
    resetPassword: (context) => const ResetPassword(),
    changePassword: (context) => const ChangePassword(),
    profile: (context) => const Profile(),
    profileNoInfo: (context) => const ProfileInput(),
    projects: (context) => const Projects(),
    projectsSaved: (context) => const ProjectsSaved(),
    welcome: (context) => const Welcome(),
    chatScreen: (context) => const ChatRoomScreen(),
    account: (context) =>
        const AccountHeader(title: 'Account', body: Account()),
    settings: (context) =>
        const AccountHeader(title: 'Settings', body: Settings()),
    languages: (context) =>
        const AccountHeader(title: 'Languages', body: Languages()),
    postJob: (context) =>
        const AccountHeader(title: 'Post Job', body: PostJob()),
  };
}

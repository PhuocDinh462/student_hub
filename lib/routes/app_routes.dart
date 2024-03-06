import 'package:flutter/material.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/Authentication/authentication.dart';
import 'package:student_hub/screens/authentication/forgot_password.dart';
import 'package:student_hub/screens/authentication/login.dart';
import 'package:student_hub/screens/authentication/verify_code.dart';
import 'package:student_hub/screens/home/Home.dart';
import 'package:student_hub/screens/profile/profile.dart';

class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot_password';
  static const String verifyCode = '/auth/verify_code';
  static const String profile = '/profile';
  static const String nav = '/nav';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const Home(),
    auth: (context) => const Authentication(),
    login: (context) => Login(),
    forgotPassword: (context) => ForgotPassword(),
    verifyCode: (context) => const VerifyCode(),
    profile: (context) => const Profile(),
    nav: (context) => const Navigation(),
  };
}

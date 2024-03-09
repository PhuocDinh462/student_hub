import 'package:flutter/material.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/Authentication/authentication.dart';
import 'package:student_hub/screens/account/account.dart';
import 'package:student_hub/screens/account/settings.dart';
import 'package:student_hub/screens/home/Home.dart';
import 'package:student_hub/screens/profile/profile.dart';
import 'package:student_hub/screens/welcome/welcome.dart';

class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String profile = '/profile';
  static const String nav = '/nav';
  static const String welcome = '/welcome';
  static const String account = '/account';
  static const String settings = '/account/settings';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const Home(),
    auth: (context) => const Authentication(),
    profile: (context) => const Profile(),
    nav: (context) => const Navigation(),
    welcome: (context) => const Welcome(),
    account: (context) => const Account(),
    settings: (context) => const Settings(),
  };
}

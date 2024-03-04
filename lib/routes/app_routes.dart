import 'package:flutter/material.dart';
import 'package:student_hub/layout/navigation.dart';
import 'package:student_hub/screens/Authentication/authentication.dart';
import 'package:student_hub/screens/home/Home.dart';
import 'package:student_hub/screens/profile/profile.dart';

class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String profile = '/profile';
  static const String nav = '/nav';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const Home(),
    auth: (context) => const Authentication(),
    profile: (context) => const Profile(),
    nav: (context) => const Navigation(),
  };
}

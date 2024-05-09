import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/screens/intro/intro.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/screens/screens.dart';

class AuthRoutes {
  static const String login = '/';
  static const String forgotPassword = '/forgot_password';
  static const String verifyCode = '/verify_code';
  static const String createAccountCompany = '/create_account_company';
  static const String createAccountStudent = '/create_account_student';
  static const String signUpOption = '/sign_up';
  static const String resetPassword = '/reset_password';
  static const String intro = '/intro';
  static const String settings = '/settings';
  static const String languages = '/settings/languages';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const Login(),
    forgotPassword: (context) => const AccountHeader(
        title: 'Student Hub',
        body: ForgotPassword(),
        userIconDestination: settings),
    verifyCode: (context) => const AccountHeader(
        title: 'Student Hub',
        body: VerifyCode(),
        userIconDestination: settings),
    createAccountCompany: (context) => const AccountHeader(
        title: 'Student Hub',
        body: CreateAccountCompany(),
        userIconDestination: settings),
    createAccountStudent: (context) => const AccountHeader(
        title: 'Student Hub',
        body: CreateAccountStudent(),
        userIconDestination: settings),
    signUpOption: (context) => const AccountHeader(
        title: 'Student Hub',
        body: SignUpOption(),
        userIconDestination: settings),
    resetPassword: (context) => const AccountHeader(
        title: 'Student Hub',
        body: ResetPassword(),
        userIconDestination: settings),
    intro: (context) => const Intro(),
    settings: (context) => AccountHeader(
        title: AppLocalizations.of(context)!.settings, body: const Settings()),
    languages: (context) => AccountHeader(
          title: AppLocalizations.of(context)!.language(''),
          body: const Languages(),
          userIconDestination: settings,
        ),
  };
}

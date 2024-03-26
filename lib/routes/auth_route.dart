import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/screens/authentication/authentication.dart';
import 'package:student_hub/screens/authentication/create_account_company.dart';
import 'package:student_hub/screens/authentication/create_account_student.dart';
import 'package:student_hub/screens/authentication/forgot_password.dart';
import 'package:student_hub/screens/authentication/login.dart';
import 'package:student_hub/screens/authentication/sign_up_option.dart';
import 'package:student_hub/screens/authentication/verify_code.dart';

import '../screens/authentication/reset_password.dart';

class AuthRoutes {
  static const String auth = '/auth';
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot_password';
  static const String verifyCode = '/auth/verify_code';
  static const String createAccountCompany = '/auth/create_account_company';
  static const String createAccountStudent = '/auth/create_account_student';
  static const String signUpOption = '/auth/sign_up';
  static const String resetPassword = '/auth/reset_password';

  static Map<String, WidgetBuilder> routes = {
    auth: (context) => const Authentication(),
    login: (context) => AccountHeader(title: 'Student Hub', body: Login()),
    forgotPassword: (context) =>
        const AccountHeader(title: 'Student Hub', body: ForgotPassword()),
    verifyCode: (context) =>
        const AccountHeader(title: 'Student Hub', body: VerifyCode()),
    createAccountCompany: (context) =>
        const AccountHeader(title: 'Student Hub', body: CreateAccountCompany()),
    createAccountStudent: (context) =>
        const AccountHeader(title: 'Student Hub', body: CreateAccountStudent()),
    signUpOption: (context) =>
        const AccountHeader(title: 'Student Hub', body: SignUpOption()),
    resetPassword: (context) =>
        const AccountHeader(title: 'Student Hub', body: ResetPassword()),
  };
}

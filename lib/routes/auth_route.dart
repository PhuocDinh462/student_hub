import 'package:flutter/material.dart';
import 'package:student_hub/layout/account_header.dart';
import 'package:student_hub/screens/authentication/authentication.dart';

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
    login: (context) =>
        const AccountHeader(title: 'Student Hub', body: Login()),
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

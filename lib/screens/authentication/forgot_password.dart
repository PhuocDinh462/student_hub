// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Text editing controller
  final TextEditingController emailController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    // Send New Password
    void sendNewPassword() async {
      final String email = emailController.text;
      FocusScope.of(context).unfocus();
      if (email.isEmpty) {
        MySnackBar.showSnackBar(context, 'Please fill in all fields', false);
        return;
      }
      try {
        final Response response = await userService.forgotPassword(email);

        if (response.statusCode == 201) {
          MySnackBar.showSnackBar(
              context, 'New Password has sent to your email', true);
          await Navigator.pushNamed(context, AuthRoutes.login);
        } else if (response.statusCode == 404) {
          MySnackBar.showSnackBar(context, 'Not Found User', false);
        } else {
          MySnackBar.showSnackBar(context, 'Invalid Credentials', false);
        }
      } catch (e) {
        MySnackBar.showSnackBar(context, 'Something went wrongs!', false);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              // Forgot Password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Gap(5),
              // Don't worry about your account
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Don\'t worry about your account',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const Gap(30),
              // Enter to send code to your email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter to send code to your email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              // Email textfield
              InputText(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                icon: Icons.email,
              ),
              const Gap(10),
              // Code will expire in 5 minutes
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Code will expire in',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      Text(
                        '5 minutes',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: primary_300),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(20),
              // Send code button
              Button(
                onTap: sendNewPassword,
                colorButton: primary_300,
                colorText: text_50,
                text: 'Send Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateAccountCompany extends StatefulWidget {
  const CreateAccountCompany({super.key});

  @override
  State<CreateAccountCompany> createState() => _CreateAccountCompanyState();
}

class _CreateAccountCompanyState extends State<CreateAccountCompany> {
  //text editting controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool agreePersonalData = false;
  final String? apiServer = dotenv.env['API_SERVER'];

  void navigateToLogin() async {
    await Navigator.pushNamed(context, AuthRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    //sign up
    void signUp() async {
      final String email = emailController.text;
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;
      final String fullname = nameController.text;
      final AuthService authService = AuthService();
      FocusScope.of(context).unfocus();

      if (email.isEmpty ||
          password.isEmpty ||
          fullname.isEmpty ||
          !agreePersonalData) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorFilledContent,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );

        return;
      }
      // checking valid email with regex
      else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(email)) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorEmailContent,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );
        return;
      }
      //checking valid password has capital letter and number
      else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$').hasMatch(password)) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorPasswordContent,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );
        return;
      } else if (password != confirmPassword) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorPasswordMatchContent,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );
        return;
      }

      try {
        final Response response =
            await authService.signUp(email, password, fullname, 1);

        if (response.statusCode == 201) {
          navigateToLogin();
          MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.sucessAccountContent,
            AppLocalizations.of(context)!.sucessTitle,
            ContentType.success,
          );
        } else {
          MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.errorAccountContent,
            AppLocalizations.of(context)!.errorTitle,
            ContentType.failure,
          );
        }
      } catch (e) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorOccuredContent,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Column(
                children: [
                  const Gap(50),
                  //welcome back
                  Text(
                    AppLocalizations.of(context)!.signUpCompany,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(30),
                  //user name textfield
                  InputText(
                    controller: nameController,
                    hintText: AppLocalizations.of(context)!.fullName,
                    obscureText: false,
                    icon: Icons.person,
                  ),
                  const Gap(20),
                  InputText(
                    controller: emailController,
                    hintText: AppLocalizations.of(context)!.inputEmailText,
                    obscureText: false,
                    icon: Icons.email,
                  ),
                  const Gap(20),

                  // password textfield
                  InputText(
                    controller: passwordController,
                    hintText: AppLocalizations.of(context)!.inputPasswordText,
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  const Gap(20),
                  // confirm password textfield
                  InputText(
                    controller: confirmPasswordController,
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: agreePersonalData,
                          onChanged: (bool? value) {
                            setState(() {
                              agreePersonalData = value ?? false;
                            });
                          },
                          activeColor: primary_300,
                        ),
                        Text(
                          AppLocalizations.of(context)!.agreePolicy,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  //sign in button
                  Button(
                    onTap: signUp,
                    colorButton: primary_300,
                    colorText: text_50,
                    text: AppLocalizations.of(context)!.createAccount,
                  ),

                  const Gap(25),
                  // not a member ? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.lookingProject,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AuthRoutes.createAccountStudent);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.applyAsStudent,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primary_200),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:student_hub/utils/snack_bar.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];
  final AuthService authService = AuthService();
  bool isObscured = true;

  void companyNavigate() async {
    await Navigator.pushNamed(context, CompanyRoutes.nav);
  }

  void studentNavigate() async {
    await Navigator.pushNamed(context, StudentRoutes.nav);
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    //sign in
    void signIn() async {
      final String email = emailController.text;
      final String password = passwordController.text;
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      FocusScope.of(context).unfocus();

      if (email.isEmpty || password.isEmpty) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorFilledContent,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );
        return;
      }
      try {
        final Response response = await authService.signIn(email, password);

        final String token = response.data['result']['token'];
        if (response.statusCode == 201) {
          userProvider.setToken(token);
          try {
            await prefs.setString('token', token);
            final userInfo = await authService.getMe();
            final companyId =
                userInfo['company'] != null ? userInfo['company']['id'] : null;
            final studentId =
                userInfo['student'] != null ? userInfo['student']['id'] : null;
            List<Role> roles = [];

            for (var role in userInfo['roles']) {
              roles.add(role == 0 ? Role.student : Role.company);
            }

            Role currentRole =
                userInfo['roles'][0] == 0 ? Role.student : Role.company;

            User currentUser = User(
              userId: userInfo['id'],
              fullname: userInfo['fullname'],
              roles: roles,
              currentRole: currentRole,
              companyId: companyId,
              studentId: studentId,
              token: token,
            );
            userProvider.setCurrentUser(currentUser);
            if (currentUser.currentRole == Role.student) {
              studentNavigate();
            } else if (currentUser.currentRole == Role.company) {
              companyNavigate();
            }
          } catch (error) {
            // Xử lý các trường hợp lỗi
          }
          MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.signInSuccessfully,
            AppLocalizations.of(context)!.sucessTitle,
            ContentType.success,
          );
        } else if (response.statusCode == 422) {
          MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.invalidCredentials,
            AppLocalizations.of(context)!.errorTitle,
            ContentType.failure,
          );
        } else {
          MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.invalidCredentials,
            AppLocalizations.of(context)!.errorTitle,
            ContentType.failure,
          );
        }
      } catch (e) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.somethingWrongs,
          AppLocalizations.of(context)!.errorTitle,
          ContentType.failure,
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                linearColor1,
                linearColor2,
                linearColor3,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
              const Gap(10),
              Text(
                'Student Hub',
                style: textTheme.displayLarge!
                    .copyWith(color: text_50, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      Text(
                        AppLocalizations.of(context)!.welcomeBack,
                        style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      const Gap(20),
                      Text(
                        AppLocalizations.of(context)!.loginToContinue,
                        style: textTheme.headlineMedium!
                            .copyWith(color: colorScheme.onSurface),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.inputEmailText,
                            suffixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: passwordController,
                          obscureText: isObscured,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.inputPasswordText,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => {
                                setState(() {
                                  isObscured = !isObscured;
                                })
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AuthRoutes.forgotPassword);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: textTheme.bodyMedium!.copyWith(
                                  color: primary_300,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: signIn,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                linearColor1,
                                linearColor2,
                                linearColor3,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: textTheme.bodyMedium!.copyWith(
                                color: text_50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dontHaveAccount,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AuthRoutes.signUpOption);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUpHere,
                              style: textTheme.bodyMedium!.copyWith(
                                color: primary_300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

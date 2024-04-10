// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:student_hub/utils/snack_bar.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

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

  void companyNavigate() async {
    await Navigator.pushNamed(context, CompanyRoutes.nav);
  }

  void studentNavigate() async {
    await Navigator.pushNamed(context, StudentRoutes.nav);
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    //sign in
    void signIn() async {
      final String email = emailController.text;
      final String password = passwordController.text;
      FocusScope.of(context).unfocus();

      if (email.isEmpty || password.isEmpty) {
        MySnackBar.showSnackBar(
          context,
          'Please fill in all fields',
          'Oh Hey!',
          ContentType.failure,
        );
        return;
      }
      try {
        final Response response = await authService.signIn(email, password);
        final String token = response.data['result']['token'];
        if (response.statusCode == 201) {
          try {
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
            print(currentUser.currentRole);
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
            'Sign in successfully',
            'Success',
            ContentType.success,
          );
        } else if (response.statusCode == 422) {
          MySnackBar.showSnackBar(
            context,
            'Invalid Credentials',
            'Oh Hey!',
            ContentType.failure,
          );
        } else {
          MySnackBar.showSnackBar(
            context,
            'Invalid Credentials',
            'Oh Hey!',
            ContentType.failure,
          );
        }
      } catch (e) {
        MySnackBar.showSnackBar(
          context,
          'Something went wrongs!',
          'Oh Hey!',
          ContentType.warning,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Gap(50),
                  //welcome back
                  Text(
                    'Welcome back to StudentHub!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(30),
                  //user name textfield
                  InputText(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    icon: Icons.email,
                  ),
                  const Gap(20),
                  // password textfield
                  InputText(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  const Gap(10),
                  //forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AuthRoutes.forgotPassword);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primary_300,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),
                  //sign in button
                  Button(
                    onTap: signIn,
                    colorButton: primary_300,
                    colorText: text_50,
                    text: 'Sign In',
                  ),

                  const Gap(25),
                  // not a member ? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AuthRoutes.signUpOption);
                        },
                        child: const Text(
                          'Sign up here',
                          style: TextStyle(
                            color: primary_200,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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

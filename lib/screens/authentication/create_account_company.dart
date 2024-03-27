import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';

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
  bool agreePersonalData = false;
  final String? apiServer = dotenv.env['API_SERVER'];

  //sign up
  void signUp() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String fullName = nameController.text;
    FocusScope.of(context).unfocus();

    if (email.isEmpty ||
        password.isEmpty ||
        fullName.isEmpty ||
        !agreePersonalData) {
      showSnackBar('Please fill in all fields', false);
      return;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        '$apiServer/auth/sign-up',
        data: {
          'email': email,
          'password': password,
          'fullName': fullName,
          'role': 0,
        },
      );

      if (response.statusCode == 201) {
        navigateToLogin();
        showSnackBar('Create account successfully', true);
      } else {
        showSnackBar('Failed to create account', false);
      }
    } catch (e) {
      showSnackBar('An error occurred during sign up', false);
    }
  }

  void navigateToLogin() async {
    await Navigator.pushNamed(context, AuthRoutes.login);
  }

  void showSnackBar(String message, bool success) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: success ? 'Congrats!!' : 'On Hey!!',
        message: message,
        contentType: success ? ContentType.success : ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // final materialBanner = MaterialBanner(
    //   /// need to set following properties for best effect of awesome_snackbar_content
    //   elevation: 0,
    //   backgroundColor: Colors.transparent,
    //   forceActionsBelow: true,
    //   content: AwesomeSnackbarContent(
    //     title: success ? 'Congrats!!' : 'On Hey!!',
    //     message:
    //         'This is an example error message that will be shown in the body of materialBanner!',

    //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
    //     contentType: success ? ContentType.success : ContentType.failure,
    //     // to configure for material banner
    //     inMaterialBanner: true,
    //   ),
    //   actions: const [SizedBox.shrink()],
    // );
    // ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
  }

  @override
  Widget build(BuildContext context) {
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
                    'Sign Up As Company',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(30),
                  //user name textfield
                  InputText(
                    controller: nameController,
                    hintText: 'Fullname',
                    obscureText: false,
                    icon: Icons.person,
                  ),
                  const Gap(20),
                  InputText(
                    controller: emailController,
                    hintText: 'Work Email Address',
                    obscureText: false,
                    icon: Icons.email,
                  ),
                  const Gap(20),

                  // password textfield
                  InputText(
                    controller: passwordController,
                    hintText: 'Password (8 or more characters)',
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  const Gap(20),
                  //forgot password
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
                          'Yes, I agree to all policies',
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
                    text: 'Create My Account',
                  ),

                  const Gap(25),
                  // not a member ? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Looking for a project ?',
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
                          'Apply as student',
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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';

class CreateAccountStudent extends StatefulWidget {
  const CreateAccountStudent({super.key});

  @override
  State<CreateAccountStudent> createState() => _CreateAccountStudentState();
}

class _CreateAccountStudentState extends State<CreateAccountStudent> {
  //text editting controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool agreePersonalData = false;

  //sign in
  void signIn() async {}

  @override
  Widget build(BuildContext context) {
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
                    'Sign Up As Student',
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
                    onTap: signIn,
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
                              context, AppRoutes.createAccountCompany);
                        },
                        child: Text(
                          'Apply as company',
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

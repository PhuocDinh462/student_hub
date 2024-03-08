import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';

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

  //sign in
  void signIn() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              //welcome back
              const Text(
                'Sign Up As Company',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
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
                      activeColor: Colors.blue,
                    ),
                    const Text(
                      'Yes, I agree to all policies',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              //sign in button
              Button(
                onTap: signIn,
                colorButton: Colors.blue,
                colorText: Colors.white,
                text: 'Create My Account',
              ),

              const Gap(25),
              // not a member ? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Looking for a project ?',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.createAccountStudent);
                    },
                    child: const Text(
                      'Apply as student',
                      style: TextStyle(
                        color: Color.fromARGB(255, 99, 183, 252),
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
    );
  }
}

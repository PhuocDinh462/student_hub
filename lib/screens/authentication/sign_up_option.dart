import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/widgets/button.dart';

class SignUpOption extends StatefulWidget {
  const SignUpOption({super.key});

  @override
  State<SignUpOption> createState() => _SignUpOptionState();
}

class _SignUpOptionState extends State<SignUpOption> {
  //text editting controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int _selectedOption = 0; // 0: Company, 1: Student
  bool agreePersonalData = false;

  //sign in
  void signIn() async {
    if (_selectedOption == 0) {
      Navigator.pushNamed(context, AppRoutes.createAccountCompany);
    } else if (_selectedOption == 1) {
      Navigator.pushNamed(context, AppRoutes.createAccountStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              //Join as Company or Student
              Text(
                'Join as Company or Student',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(30),
              //Options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _selectedOption == 0 ? Colors.blue : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile<int>(
                        title: Text(
                          'I\'m a Company, find engineer for project',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        value: 0,
                        groupValue: _selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOption = value ?? 0;
                          });
                        },
                        secondary: const Icon(Icons.business),
                        activeColor: Colors.blue,
                      ),
                    ),
                    const Gap(30),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _selectedOption == 1 ? Colors.blue : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile<int>(
                        title: Text(
                          'Student',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        value: 1,
                        groupValue: _selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOption = value ?? 1;
                          });
                        },
                        secondary: const Icon(Icons.school),
                        activeColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(30),

              //create button
              Button(
                onTap: signIn,
                colorButton: primary_300,
                colorText: text_50,
                text: 'Create Account',
              ),

              const Gap(25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold, color: primary_300),
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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  void signIn() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              //Join as Company or Student
              const Text(
                'Join as Company or Student',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
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
                        title: const Text(
                          'Company',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        title: const Text(
                          'Student',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                colorButton: Colors.blue,
                colorText: Colors.white,
                text: 'Create Account',
              ),

              const Gap(25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 99, 183, 252),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

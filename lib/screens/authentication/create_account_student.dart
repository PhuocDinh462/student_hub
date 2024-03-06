import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';

class CreateAccountStudent extends StatefulWidget {
  CreateAccountStudent({Key? key}) : super(key: key);

  @override
  _CreateAccountStudentState createState() => _CreateAccountStudentState();
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
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              //welcome back
              const Text(
                'Sign Up As Student',
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
              ),
              const Gap(20),
              InputText(
                controller: emailController,
                hintText: 'Work Email Address',
                obscureText: false,
              ),
              const Gap(20),

              // password textfield
              InputText(
                controller: passwordController,
                hintText: 'Password (8 or more characters)',
                obscureText: true,
              ),
              const Gap(20),
              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                      'Yes, I understand and agree to all policies',
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
                  const Text(
                    'Apply as company',
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

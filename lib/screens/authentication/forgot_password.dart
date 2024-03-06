import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  //text editting controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in
  void sendCode() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              //Forgot Password?
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //Don't worry about your account
              const Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Don\'t worry about your account',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Gap(30),
              //email textfield
              InputText(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const Gap(20),

              //Enter to send code to your email
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter to send code to your email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Code will expires in',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Gap(10),
                      Text(
                        '5 minutes',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              const Gap(30),
              //Sebnd code
              Button(
                onTap: sendCode,
                colorButton: Colors.blue,
                colorText: Colors.white,
                text: 'Send Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

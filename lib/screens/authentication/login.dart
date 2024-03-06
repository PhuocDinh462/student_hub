import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';

class Login extends StatelessWidget {
  Login({super.key});

  //text editting controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                'Welcome back to StudentHub!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(30),
              //user name textfield
              InputText(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const Gap(20),
              // password textfield
              InputText(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const Gap(20),
              //forgot password
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 99, 183, 252),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
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
                text: 'Sign In',
              ),

              const Gap(25),
              // not a member ? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account?',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Sign up here',
                    style: TextStyle(
                        color: Color.fromARGB(255, 99, 183, 252),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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

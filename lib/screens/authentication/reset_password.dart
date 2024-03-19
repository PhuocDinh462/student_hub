import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  //text editting controller
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agreePersonalData = false;

  //sign in
  void resetPassword() async {
    Navigator.pushNamed(context, AppRoutes.profileCompany);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(60),
              //Thêm icon lock ở đây giúp tôi
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.lock,
                    size: 60,
                    color: text_700,
                  ),
                ),
              ),
              //
              const Gap(20),
              //welcome back
              Text(
                'Reset Your Password',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(30),
              // password textfield
              InputText(
                controller: passwordController,
                hintText: 'Password (8 or more characters)',
                obscureText: true,
                icon: Icons.lock,
              ),
              const Gap(20),
              // confirm password textfield
              InputText(
                controller: confirmPasswordController,
                hintText: 'Confirm your Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              const Gap(50),

              //Reset Password
              Button(
                onTap: resetPassword,
                colorButton: primary_300,
                colorText: text_50,
                text: 'Reset Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

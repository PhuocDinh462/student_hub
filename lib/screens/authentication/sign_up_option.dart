import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      Navigator.pushNamed(context, AuthRoutes.createAccountCompany);
    } else if (_selectedOption == 1) {
      Navigator.pushNamed(context, AuthRoutes.createAccountStudent);
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
                AppLocalizations.of(context)!.joinAsRoles,
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
                          AppLocalizations.of(context)!.companyOption,
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
                          AppLocalizations.of(context)!.studentOption,
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
                text: AppLocalizations.of(context)!.createAccount,
              ),

              const Gap(25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.haveAccount,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AuthRoutes.login);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
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

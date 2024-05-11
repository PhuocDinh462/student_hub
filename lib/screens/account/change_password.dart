// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/providers/user.provider.dart';
import 'package:student_hub/utils/snack_bar.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //text editting controller
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final UserService userService = UserService();

  bool agreePersonalData = false;

  //sign in
  Future<dynamic> changePassword(UserProvider userProvider) async {
    final String oldPassword = oldPasswordController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (oldPassword.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      MySnackBar.showSnackBar(
        context,
        AppLocalizations.of(context)!.errorFilledContent,
        AppLocalizations.of(context)!.errorOccuredContent,
        ContentType.failure,
      );
      return;
    }
    if (password != confirmPassword) {
      MySnackBar.showSnackBar(
        context,
        AppLocalizations.of(context)!.samePassword,
        AppLocalizations.of(context)!.errorOccuredContent,
        ContentType.failure,
      );
      return;
    }
    try {
      await userService.changePassword(oldPassword, password);
      MySnackBar.showSnackBar(
        context,
        AppLocalizations.of(context)!.changePassword,
        AppLocalizations.of(context)!.sucessTitle,
        ContentType.success,
      );
      Navigator.pushNamed(context, '/account');
      // if (userProvider.currentUser!.currentRole == Role.student) {
      //   Navigator.pushNamed(context, StudentRoutes.account);
      // } else {
      //   Navigator.pushNamed(context, CompanyRoutes.account);
      // }
    } catch (e) {
      MySnackBar.showSnackBar(
        context,
        AppLocalizations.of(context)!.failedChangePass,
        AppLocalizations.of(context)!.errorOccuredContent,
        ContentType.failure,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.lock,
                      size: 60,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                //
                const Gap(20),
                //welcome back
                Text(
                  AppLocalizations.of(context)!.changePasswordTitle,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(30),
                //old password textfield
                InputText(
                  controller: oldPasswordController,
                  hintText: AppLocalizations.of(context)!.oldPasswordHint,
                  obscureText: true,
                  icon: Icons.vpn_key,
                ),
                const Gap(20),
                // password textfield
                InputText(
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.newPassword,
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const Gap(20),
                // confirm password textfield
                InputText(
                  controller: confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const Gap(50),

                //Reset Password
                Button(
                  onTap: () => changePassword(userProvider),
                  colorButton: Theme.of(context).colorScheme.tertiary,
                  colorText: Theme.of(context).colorScheme.onPrimary,
                  text: AppLocalizations.of(context)!.changePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

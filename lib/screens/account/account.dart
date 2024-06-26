import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/screens/account/widgets/user_item.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/widgets/yes_no_dialog.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    final AuthService authService = AuthService();

    void logout() async {
      context.loaderOverlay.show();
      await getToken().then((value) async {
        await authService
            .logout(value!, user)
            .whenComplete(() => context.loaderOverlay.hide());
      });
    }

    return ListView(
      children: [
        // Users
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListTileTheme(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            minVerticalPadding: 20,
            dense: true,
            horizontalTitleGap: 10,
            minLeadingWidth: 0,
            child: ExpansionTile(
              leading: Icon(
                  user.currentUser!.currentRole == Role.student
                      ? Icons.school_outlined
                      : Icons.business,
                  size: 46),
              title: Text(
                user.currentUser?.fullname ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.user(
                    user.currentUser!.currentRole == Role.student
                        ? 'student'
                        : 'company'),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
              children: <Widget>[
                const Gap(5),
                if (user.currentUser!.roles.contains(
                    user.currentUser!.currentRole == Role.student
                        ? Role.company
                        : Role.student))
                  Row(
                    children: [
                      const Gap(40),
                      Expanded(
                        child: UserItem(
                            username: user.currentUser?.fullname ?? '',
                            role: user.currentUser!.currentRole == Role.student
                                ? Role.company
                                : Role.student,
                            actionChangeRole: (role) {
                              user.setCurrentUser(user.currentUser!.copyWith(
                                currentRole: role,
                              ));
                            }),
                      )
                    ],
                  ),
                if (user.currentUser!.roles.length < 2)
                  InkWell(
                    onTap: () {
                      if (user.currentUser!.currentRole == Role.student) {
                        Get.toNamed(StudentRoutes.profileCompany);
                      } else {
                        Get.toNamed(CompanyRoutes.profileStudentStepOne);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Gap(40),
                          const Icon(Icons.add_circle_outline_outlined,
                              size: 28),
                          const Gap(8),
                          Text(AppLocalizations.of(context)!.addProfile),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const Divider(height: 0, thickness: .5, endIndent: 0, color: text_400),

        // Others setting
        InkWell(
          onTap: () {
            if (user.currentUser!.currentRole == Role.company) {
              Get.toNamed(StudentRoutes.profileCompany);
            } else {
              Get.toNamed(CompanyRoutes.profileStudentStepOne);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.account_box, size: 32),
                const Gap(10),
                Text(
                  AppLocalizations.of(context)!.account('profiles'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: .5,
          indent: 40,
          endIndent: 20,
          color: text_400,
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, CompanyRoutes.settings),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.settings, size: 32),
                const Gap(10),
                Text(
                  AppLocalizations.of(context)!.account('settings'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: .5,
          indent: 40,
          endIndent: 20,
          color: text_400,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(StudentRoutes.changePassword);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.lock, size: 32),
                const Gap(10),
                Text(
                  AppLocalizations.of(context)!.account('changePassword'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: .5,
          indent: 40,
          endIndent: 20,
          color: text_400,
        ),
        InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return YesNoDialog(
                title: AppLocalizations.of(context)!.account('logout'),
                content: AppLocalizations.of(context)!.logoutConfirm,
                onYesPressed: () => logout(),
              );
            },
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.logout_rounded,
                    size: 32,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 255, 116, 106)
                        : Colors.red),
                const Gap(10),
                Text(
                  AppLocalizations.of(context)!.account('logout'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 255, 116, 106)
                          : Colors.red),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

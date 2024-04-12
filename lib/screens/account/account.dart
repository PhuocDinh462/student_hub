import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/screens/account/widgets/user_item.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Users
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ListTileTheme(
                contentPadding: const EdgeInsets.all(0),
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
                          const Gap(30),
                          UserItem(
                              username: user.currentUser?.fullname ?? '',
                              role: user.currentUser!.currentRole),
                        ],
                      ),
                    if (user.currentUser!.roles.length < 2)
                      GestureDetector(
                        onTap: () {
                          if (user.currentUser!.currentRole == Role.student) {
                            Get.toNamed(CompanyRoutes.profileCompany);
                          } else {
                            Get.toNamed(StudentRoutes.profileStudentStepOne);
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: const Row(
                            children: [
                              Gap(30),
                              Icon(Icons.add_circle_outline_outlined, size: 28),
                              Gap(8),
                              Text('Add profile'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Divider(
                height: 40, thickness: .5, endIndent: 0, color: text_400),

            // Others setting
            GestureDetector(
              onTap: () => Get.toNamed(CompanyRoutes.profileCompany),
              child: Container(
                color: Colors.transparent,
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
              height: 50,
              thickness: .5,
              indent: 40,
              color: text_400,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, CompanyRoutes.settings),
              child: Container(
                color: Colors.transparent,
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
              height: 50,
              thickness: .5,
              indent: 40,
              color: text_400,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(StudentRoutes.changePassword);
              },
              child: Container(
                color: Colors.transparent,
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
              height: 50,
              thickness: .5,
              indent: 40,
              color: text_400,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
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
        ),
      ),
    );
  }
}

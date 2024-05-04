import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeCompany extends StatelessWidget {
  const WelcomeCompany({super.key, required this.appLocal});
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${appLocal.welcome} ${user.currentUser?.fullname}!'),
                Text(appLocal.descriptionWelcomeCompany),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (user.currentUser!.currentRole == Role.student) {
                  user.setCurrentUser(user.currentUser!.copyWith(
                      currentRole: Role.company,
                      roles: [Role.student, Role.company]));
                } else {
                  Navigator.pushNamed(context, CompanyRoutes.nav,
                      arguments: {'index': 1});
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary_300,
                foregroundColor: text_50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(appLocal.gettingStarted),
            ),
          ],
        ),
      ),
    );
  }
}

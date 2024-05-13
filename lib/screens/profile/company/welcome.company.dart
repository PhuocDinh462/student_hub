import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeCompany extends StatelessWidget {
  const WelcomeCompany({super.key, required this.appLocal});
  final AppLocalizations appLocal;

  Future<void> hanldeUpdateCurrentUser(
      UserProvider userProvider, Role currentRole) async {
    AuthService authService = AuthService();

    try {
      final userInfo = await authService.getMe();
      final companyId =
          userInfo['company'] != null ? userInfo['company']['id'] : null;
      final studentId =
          userInfo['student'] != null ? userInfo['student']['id'] : null;
      List<Role> roles = [];

      for (var role in userInfo['roles']) {
        roles.add(role == 0 ? Role.student : Role.company);
      }

      User currentUser = User(
        userId: userInfo['id'],
        fullname: userInfo['fullname'],
        roles: roles,
        currentRole: currentRole,
        companyId: companyId,
        studentId: studentId,
      );
      userProvider.setCurrentUser(currentUser);
    } catch (e) {
      throw Exception(e);
    }
  }

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
                hanldeUpdateCurrentUser(user, Role.company).then((value) {
                  if (user.currentUser!.currentRole != Role.student) {
                    Navigator.pushNamed(context, CompanyRoutes.nav,
                        arguments: {'index': 1});
                  }
                });
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

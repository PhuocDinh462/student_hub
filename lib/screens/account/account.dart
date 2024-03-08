import 'package:flutter/material.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/screens/account/widgets/account_item.dart';
import 'package:flutter_gap/flutter_gap.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: const ExpansionTile(
                leading: Icon(Icons.person, size: 46),
                title: Text(
                  'Hai Pham',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Text(
                  'Student',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                children: <Widget>[
                  Gap(5),
                  Row(
                    children: [
                      Gap(40),
                      AccountItem(
                          username: 'Hai Pham', userType: UserType.company),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

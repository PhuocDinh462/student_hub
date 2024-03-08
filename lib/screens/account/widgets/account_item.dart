import 'package:flutter/material.dart';
import 'package:student_hub/models/user.dart';
import 'package:flutter_gap/flutter_gap.dart';

class AccountItem extends StatelessWidget {
  final String username;
  final UserType userType;

  const AccountItem({
    super.key,
    required this.username,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tap');
      },
      child: Row(
        children: [
          Icon(userType == UserType.student ? Icons.person : Icons.business,
              size: 46),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Text(
                userType == UserType.student ? 'Student' : 'Company',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

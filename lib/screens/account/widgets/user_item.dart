import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserItem extends StatelessWidget {
  final String username;
  final Role role;
  final Function(Role) actionChangeRole;

  const UserItem({
    super.key,
    required this.username,
    required this.role,
    required this.actionChangeRole,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        actionChangeRole(role);
      },
      child: Row(
        children: [
          Icon(role == Role.student ? Icons.school_outlined : Icons.business,
              size: 32),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                AppLocalizations.of(context)!
                    .user(role == Role.student ? 'student' : 'company'),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
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

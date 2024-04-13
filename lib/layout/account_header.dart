import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';

class AccountHeader extends StatelessWidget {
  final String title;
  final Widget body;
  final bool resizeToAvoidBottomInset;

  const AccountHeader({
    super.key,
    required this.title,
    required this.body,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        automaticallyImplyLeading: ModalRoute.of(context)?.isFirst ?? true,
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        leading: ModalRoute.of(context)!.settings.name != '/'
            ? IconButton(
                icon: const Icon(Icons.chevron_left, size: 36, color: text_50),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: text_50,
                fontSize: 24,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                size: 32,
                color: text_50,
              ),
              onPressed: () => Navigator.pushNamed(context, '/account'),
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}

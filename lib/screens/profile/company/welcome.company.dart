import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/app_routes.dart';

class WelcomeCompany extends StatelessWidget {
  const WelcomeCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome, Hai!'),
                Text("Let's start with your first project post!"),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.dashboardStudent),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary_300,
                foregroundColor: text_50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Get started!'),
            ),
          ],
        ),
      ),
    );
  }
}

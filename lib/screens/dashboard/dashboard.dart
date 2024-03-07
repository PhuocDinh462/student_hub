import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/theme_provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Your jobs'),
                ElevatedButton.icon(
                  onPressed: () {
                    themeProvider.setThemeMode(!themeProvider.getThemeMode);
                  },
                  icon: const Icon(Icons.post_add),
                  label: const Text('Post a job'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary_300,
                    foregroundColor: text_50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Column(
              children: [
                Text('Welcome, Hai!'),
                Text('You have no jobs!'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

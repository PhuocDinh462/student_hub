import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Build your product with high-skilled student',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 80),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.business,
                size: 24.0,
              ),
              label: const Text('Company'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 40),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.people,
                size: 24.0,
              ),
              label: const Text('Student'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 40),
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              'StudentHub is university market place to connect high-skilled student and company on a real-world project',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

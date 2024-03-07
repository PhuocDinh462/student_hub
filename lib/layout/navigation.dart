import 'package:flutter/material.dart';
import 'package:student_hub/screens/dashboard/dashboard.dart';
import 'package:student_hub/screens/projects/projects.dart';
import 'package:student_hub/constants/colors.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) =>
            setState(() => currentScreenIndex = index),
        indicatorColor: primary_300,
        selectedIndex: currentScreenIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.task,
              color: currentScreenIndex == 0 ? text_100 : text_900,
            ),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.dashboard,
              color: currentScreenIndex == 1 ? text_100 : text_900,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.message,
              color: currentScreenIndex == 2 ? text_100 : text_900,
            ),
            label: 'Message',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.notifications,
              color: currentScreenIndex == 3 ? text_100 : text_900,
            ),
            label: 'Alerts',
          ),
        ],
      ),
      body: <Widget>[
        const Projects(),
        const Dashboard(),
        const Text('Message'),
        const Text('Alerts'),
      ][currentScreenIndex],
    );
  }
}

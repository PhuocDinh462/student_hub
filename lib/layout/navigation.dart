import 'package:flutter/material.dart';
import 'package:student_hub/screens/alerts/alert.screen.dart';
import 'package:student_hub/screens/chat/chat.dart';
import 'package:student_hub/screens/dashboard/company/dashboard.dart';
import 'package:student_hub/screens/project/projects.dart';
import 'package:student_hub/constants/theme.dart';

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
        indicatorColor: primary_200,
        backgroundColor: Colors.transparent,
        selectedIndex: currentScreenIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.task,
            ),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.dashboard,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.message,
            ),
            label: 'Message',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'Alerts',
          ),
        ],
      ),
      body: <Widget>[
        const Projects(),
        const Dashboard(),
        const MessageListScreen(),
        const AlertScreen(),
      ][currentScreenIndex],
    );
  }
}

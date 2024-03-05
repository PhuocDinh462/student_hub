import 'package:flutter/material.dart';
import 'package:student_hub/screens/projects/projects.dart';

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
        // indicatorColor: Colors.blue,
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
        const Text('Dashboard'),
        const Text('Message'),
        const Text('Alerts'),
      ][currentScreenIndex],
    );
  }
}
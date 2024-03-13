import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/theme_provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: themeProvider.getThemeMode ? text_900 : text_50,
        backgroundColor: themeProvider.getThemeMode ? primary_200 : primary_300,
        child: const Icon(Icons.add),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              dividerColor: themeProvider.getThemeMode ? text_800 : text_200,
              tabs: const [
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Tab(
                    child: Text(
                      'All projects',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Tab(
                    child: Text(
                      'Working',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Tab(
                    child: Text(
                      'Archived',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Text('All projects'),
                  ),
                  Center(
                    child: Text('Working'),
                  ),
                  Center(
                    child: Text('Archived'),
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

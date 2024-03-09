import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/theme_provider.dart';

class HeaderLayout extends StatelessWidget {
  final Widget body;
  const HeaderLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      theme:
          themeProvider.getThemeMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Student Hub',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: text_50,
                  fontSize: 24,
                ),
              ),
              Icon(
                Icons.person,
                size: 32,
                color: text_50,
              ),
            ],
          ),
        ),
        body: body,
      ),
    );
  }
}

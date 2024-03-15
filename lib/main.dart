import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/layout/header_layout.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IndexPageProvider()),
        ChangeNotifierProvider(create: (_) => OpenIdProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return HeaderLayout(
      body: MaterialApp(
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.profileStudentStepOne,
        debugShowCheckedModeBanner: false,
        theme: themeProvider.getThemeMode
            ? AppTheme.darkTheme
            : AppTheme.lightTheme,
      ),
    );
  }
}

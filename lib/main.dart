import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_hub/layout/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return const MaterialApp(
      home: SafeArea(child: Navigation()),
      debugShowCheckedModeBanner: false,
    );
  }
}

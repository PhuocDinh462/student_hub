import 'package:flutter/material.dart';
import 'package:student_hub/screens/alerts/widgets/alerts.widgets.dart';
import 'package:student_hub/utils/utils.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  List<TypeAlert> lst = [
    TypeAlert.text,
    TypeAlert.invite,
    TypeAlert.offer,
    TypeAlert.chat,
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: lst.length,
              itemBuilder: (ctx, index) {
                return AlertItem(
                  type: lst[index],
                );
              })),
    );
  }
}

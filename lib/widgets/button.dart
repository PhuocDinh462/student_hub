import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.onTap,
      required this.text,
      required this.colorButton,
      required this.colorText});
  final Function()? onTap;
  final String text;
  final Color colorButton;
  final Color colorText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: colorButton, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: colorText, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

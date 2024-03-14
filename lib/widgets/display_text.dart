import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  const DisplayText(
      {super.key, required this.text, this.textAlign, required this.style});
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}

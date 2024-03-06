import 'package:flutter/material.dart';
import 'package:student_hub/utils/utils.dart';

class DisplayText extends StatelessWidget {
  const DisplayText(
      {super.key,
      required this.text,
      this.size,
      this.fontWeight,
      this.color,
      this.textAlign});
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
        color: color,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}

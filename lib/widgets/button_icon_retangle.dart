import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';

class ButtonIconRetangle extends StatelessWidget {
  const ButtonIconRetangle(
      {super.key,
      required this.icon,
      this.width = 40,
      this.height = 40,
      this.iconSize = 18,
      this.iconColor = Colors.white,
      this.backgroundColor = primary_300,
      required this.onPressed});
  final double width;
  final double height;
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: IconButton(
        iconSize: iconSize,
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          iconColor: WidgetStateProperty.resolveWith((states) => iconColor),
          backgroundColor:
              WidgetStateProperty.resolveWith((states) => backgroundColor),
        ),
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon),
      ),
    );
  }
}

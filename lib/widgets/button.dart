import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.text,
    required this.colorButton,
    required this.colorText,
  });

  final Function()? onTap;
  final String text;
  final Color colorButton;
  final Color colorText;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _opacity = 0.5;
        });
      },
      onTapUp: (_) {
        setState(() {
          _opacity = 1.0;
        });
      },
      onTapCancel: () {
        setState(() {
          _opacity = 1.0;
        });
      },
      onTap: widget.onTap,
      child: Opacity(
        opacity: _opacity,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: widget.colorButton,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.colorText,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
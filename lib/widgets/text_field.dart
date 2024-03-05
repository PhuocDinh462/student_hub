import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const InputText(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(189, 189, 189, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 133, 242),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: const Color.fromRGBO(238, 238, 238, 1),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

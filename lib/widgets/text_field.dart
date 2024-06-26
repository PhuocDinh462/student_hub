import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  const InputText(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          labelText: hintText,
          fillColor: Theme.of(context).cardColor,
          filled: true,
          labelStyle: Theme.of(context).textTheme.bodySmall!,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .color!
                  .withOpacity(0.5)),
        ),
      ),
    );
  }
}

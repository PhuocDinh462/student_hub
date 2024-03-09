import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/display_text.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.maxLines,
      this.suffixIcon,
      this.readOnly = false});

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(
          text: title,
          color: text_900,
          fontWeight: FontWeight.w600,
          size: 16,
        ),
        const Gap(10),
        TextField(
            autofocus: true,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                hintText: hintText,
                suffixIcon: suffixIcon,
                hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))))),
      ],
    );
  }
}

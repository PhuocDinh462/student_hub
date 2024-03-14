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
      this.readOnly = false,
      this.focusNode});

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(
          text: title,
          style: textTheme.bodyLarge!,
        ),
        const Gap(10),
        TextField(
            focusNode: focusNode,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            style: textTheme.bodySmall,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintText: hintText,
              suffixIcon: suffixIcon,
              hintStyle: textTheme.bodySmall!.copyWith(color: text_400),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.onSurface),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            )),
      ],
    );
  }
}

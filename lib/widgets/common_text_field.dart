import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/display_text.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.focusNode,
    this.child,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (focusNode != null) {
      focusNode!.addListener(() {
        Provider.of<GlobalProvider>(context, listen: false)
            .setFocus(focusNode!.hasFocus);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(
          text: title,
          style: textTheme.bodyLarge!,
        ),
        if (title != '') const Gap(10),
        if (child != null) child!,
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
                  borderSide: BorderSide(color: colorScheme.onSurface),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.onSurface),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            )),
      ],
    );
  }
}

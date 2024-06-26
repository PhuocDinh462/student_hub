import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/display_text.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.isNumber = false,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(
          text: title,
          style: textTheme.bodyLarge!,
        ),
        const Gap(10),
        TextField(
            // autofocus: true,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(
                    decimal: false, signed: true)
                : TextInputType.text,
            onChanged: (value) async {
              if (isNumber) {
                if (double.tryParse(value) == null && value.isNotEmpty) {
                  final newValue = value.substring(0, value.length - 1);
                  controller?.text = newValue;
                  controller?.selection = TextSelection.fromPosition(
                    TextPosition(offset: newValue.length),
                  );
                }
              }
            },
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintText: hintText,
              suffixIcon: suffixIcon,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              // enabledBorder: OutlineInputBorder(
              //   borderSide: const BorderSide(
              //     color: text_400,
              //     width: 2.0,
              //   ),
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
              // border: const OutlineInputBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(10)))
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

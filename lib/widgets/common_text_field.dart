import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/display_text.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines = 1,
    this.suffixIcon,
    this.readOnly = false,
    this.child,
    this.titleStyle,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final Widget? child;
  final TextStyle? titleStyle;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GlobalProvider>(context, listen: false).setFocus(false);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // ignore: deprecated_member_use
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    GlobalProvider globalProvider =
        Provider.of<GlobalProvider>(context, listen: false);

    if (!globalProvider.isFocus && bottomInset > 0) {
      globalProvider.setFocus(true);
    } else if (globalProvider.isFocus && bottomInset == 0) {
      globalProvider.setFocus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    FocusNode focusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisplayText(
          text: widget.title,
          style: widget.titleStyle ?? textTheme.bodyLarge!,
        ),
        if (widget.title != '') const Gap(10),
        if (widget.child != null) widget.child!,
        TextField(
            focusNode: focusNode,
            readOnly: widget.readOnly,
            controller: widget.controller,
            maxLines: widget.maxLines,
            style: textTheme.bodySmall,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
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

import 'package:flutter/material.dart';
import 'package:student_hub/widgets/widgets.dart';

class DisplayRadioList extends StatefulWidget {
  const DisplayRadioList(
      {super.key,
      required this.items,
      required this.numSelected,
      this.onChange});
  final List<String> items;
  final int numSelected;
  final void Function(BuildContext, int)? onChange;
  @override
  State<DisplayRadioList> createState() => _DisplayRadioListState();
}

class _DisplayRadioListState extends State<DisplayRadioList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return widget.onChange == null
        ? Row(
            children: [
              const Radio(value: 0, groupValue: 0, onChanged: null),
              DisplayText(
                text: widget.items[0],
                style: textTheme.bodySmall!,
              )
            ],
          )
        : ListView.builder(
            itemCount: widget.items.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemExtent: 40,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                  onTap: () {
                    widget.onChange!(context, index);
                  },
                  child: Row(
                    children: [
                      Radio(
                        value: index,
                        groupValue:
                            widget.onChange == null ? 0 : widget.numSelected,
                        onChanged: widget.onChange == null
                            ? null
                            : (value) {
                                widget.onChange!(context, index);
                              },
                      ),
                      DisplayText(
                        text: widget.items[index],
                        style: textTheme.bodySmall!,
                      )
                    ],
                  ));
            },
          );
  }
}

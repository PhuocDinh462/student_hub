import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProjectLengthOptions extends StatefulWidget {
  const ProjectLengthOptions({super.key, required this.options});
  final List<String> options;

  @override
  State<ProjectLengthOptions> createState() => _ProjectLengthOptionsState();
}

class _ProjectLengthOptionsState extends State<ProjectLengthOptions> {
  int curOption = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.options.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemExtent: 40,
      itemBuilder: (ctx, index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                curOption = index;
              });
            },
            child: Row(
              children: [
                Radio(
                  value: index,
                  groupValue: curOption,
                  onChanged: (value) {
                    setState(() {
                      curOption = value!;
                    });
                  },
                ),
                DisplayText(
                  text: widget.options[index],
                  color: text_900,
                  fontWeight: FontWeight.w400,
                  size: 16,
                )
              ],
            ));
      },
    );
  }
}

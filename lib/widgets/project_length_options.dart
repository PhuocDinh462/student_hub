import 'package:flutter/material.dart';
import 'package:student_hub/widgets/widgets.dart';

class ProjectLengthOptions extends StatefulWidget {
  const ProjectLengthOptions({
    super.key,
    required this.options,
    required this.onOptionSelected,
  });
  final List<String> options;
  final void Function(int selectedOption) onOptionSelected;

  @override
  State<ProjectLengthOptions> createState() => _ProjectLengthOptionsState();
}

class _ProjectLengthOptionsState extends State<ProjectLengthOptions> {
  int curOption = 0;
  @override
  void initState() {
    super.initState();
    // Set initial selected option to the first one
    curOption = 0;
  }

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
                widget.onOptionSelected(curOption);
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
                      widget.onOptionSelected(curOption);
                    });
                  },
                ),
                DisplayText(
                  text: widget.options[index],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ));
      },
    );
  }
}

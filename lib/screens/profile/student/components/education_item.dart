import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class EducationItem extends StatelessWidget {
  const EducationItem(
      {super.key,
      required this.edu,
      required this.isEdit,
      required this.itemsChecked,
      required this.onEdit,
      required this.onChangeCheck});

  final EducationModel edu;
  final bool isEdit;
  final List<int> itemsChecked;
  final Function() onEdit;
  final Function(int, bool?) onChangeCheck;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: deviceSize.width * 0.6,
                  child: DisplayText(
                      text: edu.schoolName, style: textTheme.bodySmall!),
                ),
                DisplayText(
                    text: '${edu.startYear} - ${edu.endYear}',
                    style: textTheme.labelSmall!.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.8),
                        fontSize: 12)),
              ],
            ),
            if (isEdit)
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: IconButton(
                        iconSize: 20,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          onEdit();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: primary_300,
                        )),
                  ),
                  const Gap(25),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                        checkColor: Colors.white,
                        fillColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.selected)) {
                            return primary_300;
                          }
                          return Colors.white;
                        }),
                        value: itemsChecked.contains(-1)
                            ? true
                            : itemsChecked.contains(edu.id),
                        onChanged: (bool? value) {
                          onChangeCheck(
                            edu.id,
                            value,
                          );
                        }),
                  ),
                  const Gap(9),
                ],
              )
          ],
        ),
        Divider(
          color: colorScheme.onSurface,
          thickness: 0.2,
        )
      ],
    );
  }
}

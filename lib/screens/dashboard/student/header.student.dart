import 'package:flutter/material.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class HeaderStudentDashboard extends StatelessWidget {
  const HeaderStudentDashboard({super.key, required this.headerTitle});
  final List<String> headerTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;

    return CommonContainer(
        width: deviceSize.width,
        color: colorScheme.background,
        padding: const EdgeInsets.all(20),
        borderRadius: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: DisplayText(
              text: 'Your project',
              style: textTheme.headlineLarge!,
            ),
          ),
          Center(
            child: CommonTabbarButton(
                listItem: headerTitle,
                width: deviceSize.width * 0.9,
                space: 5,
                height: 50),
          )
        ]));
  }
}

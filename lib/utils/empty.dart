import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/utils/extensions.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Empty.png',
          width: context.deviceSize.width / 1.5,
        ),
        const Gap(10),
        Text(
          'No data available',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Gap(60),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/utils/extensions.dart';

class Empty extends StatelessWidget {
  const Empty({
    super.key,
    this.imgPath = 'assets/images/Empty.png',
    this.text = 'No data available',
  });

  final String imgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: context.deviceSize.width / 1.5,
        ),
        const Gap(10),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Gap(60),
      ],
    );
  }
}

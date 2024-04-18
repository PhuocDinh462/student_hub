import 'package:flutter/material.dart';
import 'package:student_hub/constants/skills.dart';

class SkillItem extends StatelessWidget {
  const SkillItem({super.key, required this.skill});
  final String skill;
  final double size = 60;

  @override
  Widget build(BuildContext context) {
    String skillUrl = skills[skill] ?? '';
    return skillUrl.isNotEmpty
        ? Image.asset(
            'assets/images/skills/${Theme.of(context).brightness == Brightness.light ? 'light' : 'dark'}/$skillUrl',
            width: size,
            height: size)
        : Text(skill);
  }
}

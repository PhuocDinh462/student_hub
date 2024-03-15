import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/common_dropdown_menu.dart';

class AllProjectStudent extends StatefulWidget {
  const AllProjectStudent({
    super.key,
  });

  @override
  State<AllProjectStudent> createState() => _AllProjectStudentState();
}

class _AllProjectStudentState extends State<AllProjectStudent> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CommonDropdownMenu(
          id: 1,
          labelText: 'Active proposal (0)',
        ),
        Gap(20),
        CommonDropdownMenu(
          id: 2,
          labelText: 'Submitted proposal (0)',
        ),
      ],
    );
  }
}

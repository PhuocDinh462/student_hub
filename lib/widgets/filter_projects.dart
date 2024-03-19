import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/project_length_options.dart';
import 'package:student_hub/widgets/text_field_title.dart';

class FilterProject extends StatefulWidget {
  const FilterProject({super.key});

  @override
  State<FilterProject> createState() => _FilterProjectState();
}

class _FilterProjectState extends State<FilterProject> {
  final studentsController = TextEditingController();
  final proposalsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Đặt màu nền trong suốt
      body: Stack(
        children: [
          // Icon "exit" ở góc trái
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Đóng widget FilterProject khi nhấn icon exit
                      },
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1.5,
                  color: primary_300,
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Project Length',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const ProjectLengthOptions(
                  options: [
                    'All',
                    'Less than one month',
                    '1 to 3 months',
                    '3 to 6 months',
                    'More than 6 months',
                  ],
                ),
                const Gap(20),
                TextFieldTitle(
                  title: 'Students Needed',
                  hintText: 'Enter Number of Students',
                  controller: studentsController,
                ),
                const Gap(16),
                TextFieldTitle(
                  title: 'Proposals less than',
                  hintText: 'Enter Number of Proposals',
                  controller: proposalsController,
                ),
                const Gap(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'Clear filters',
                      colorButton: primary_300,
                      colorText: text_50,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Button(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'Apply',
                      colorButton: primary_300,
                      colorText: text_50,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

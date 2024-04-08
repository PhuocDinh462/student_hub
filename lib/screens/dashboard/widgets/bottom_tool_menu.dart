import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/post_job_provider.dart';
import 'package:student_hub/routes/company_route.dart';

class BottomToolMenu extends StatelessWidget {
  const BottomToolMenu({super.key});
  final double itemHeight = 60;

  @override
  Widget build(BuildContext context) {
    final PostJobProvider postJobProvider =
        Provider.of<PostJobProvider>(context);

    return Container(
      height: 275,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // View
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CompanyRoutes.projectDetail);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'View',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'View job posting',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Divider(height: 30, thickness: .5, color: text_600),

          // Edit
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'Edit posting',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Divider(height: 30, thickness: .5, color: text_600),

          // Remove
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmation'),
                    content: const Text(
                        'Are you sure you want to remove this posting?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Perform the remove action
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Cancel the remove action
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remove',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'Remove posting',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Divider(height: 30, thickness: .5, color: text_600),

          // Start
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    Icons.start_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(3),
                      Text(
                        'Start working this project',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

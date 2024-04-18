import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/utils/extensions.dart';
// import 'package:get/get.dart';

class ProposalDetail extends StatelessWidget {
  const ProposalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // final int proposalId = Get.arguments;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile
            Row(
              children: [
                Image.asset(
                  'assets/images/user.png',
                  width: 80,
                ),
                const Gap(20),
                SizedBox(
                  width: context.deviceSize.width - 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phuoc Dinh Cao Hong',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const Gap(5),
                      Text(
                        'Fullstack Engineer',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Gap(15),
            // Cover letter
            SizedBox(
              width: context.deviceSize.width - 30,
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                textAlign: TextAlign.left,
              ),
            ),
            const Gap(30),
            // Educations
            Row(
              children: [
                Text(
                  'Educations',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontStyle: FontStyle.italic),
                ),
                const Expanded(
                  child: Divider(
                    height: 40,
                    thickness: .5,
                    indent: 30,
                    color: text_400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('University of Science - VNUHCM'),
                Text('2020 - 2024',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

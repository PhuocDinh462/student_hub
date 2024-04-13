import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CompanyRoutes.chatScreen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child:
                          //  Container(
                          //   margin: const EdgeInsets.only(right: 3),
                          //   child: const Icon(
                          //     Icons.circle,
                          //     size: 14,
                          //     color: Colors.green,
                          //   ),
                          // ),
                          Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: Colors.green.withOpacity(0.2)),
                        child: DisplayText(
                          text: '12p',
                          style: textTheme.labelLarge!.copyWith(fontSize: 8),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayText(
                  text: 'User 2',
                  style: textTheme.labelMedium!,
                ),
                DisplayText(
                    text: 'Senior frontend developer (Fintech)',
                    style: textTheme.labelSmall!.copyWith(
                      fontSize: 10,
                      color: colorScheme.onSurface,
                    )),
                const Gap(5),
                Row(
                  children: [
                    SizedBox(
                      width: deviceSize.width * 0.55,
                      child: DisplayText(
                        text:
                            'Clear expectation about your project or deliverables',
                        style: textTheme.labelSmall!
                            .copyWith(color: colorScheme.onSurface),
                      ),
                    ),
                    DisplayText(
                      text: '· 00:00',
                      style: textTheme.labelSmall!
                          .copyWith(color: colorScheme.onSurface),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

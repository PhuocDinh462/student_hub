import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser?.userId;

    final name = userId == message.sender?.id
        ? message.receiver!.fullname
        : message.sender?.fullname;

    return InkWell(
      onTap: () {
        if (message.receiver?.id == userId) {
          Navigator.of(context).pushNamed(CompanyRoutes.chatScreen, arguments: {
            'user': message.receiver,
            'otherUser': message.sender,
            'project': message.projectModel
          });
        } else {
          Navigator.of(context).pushNamed(CompanyRoutes.chatScreen, arguments: {
            'user': message.sender,
            'otherUser': message.receiver,
            'project': message.projectModel
          });
        }
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
                    child: const Icon(
                      Icons.circle,
                      size: 14,
                      color: Colors.green,
                    ),
                    //   Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 4),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(1000),
                    //     color: Colors.green.withOpacity(0.2)),
                    // child: DisplayText(
                    //   text: '12p',
                    //   style: textTheme.labelLarge!.copyWith(fontSize: 8),
                    // ),
                    // )
                  ),
                ],
              ),
            ),
            const Gap(5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayText(
                  text: name!,
                  style: textTheme.labelMedium!,
                ),
                if (message.projectModel!.title.isNotEmpty)
                  DisplayText(
                      text: message.projectModel!.title,
                      style: textTheme.labelSmall!.copyWith(
                        fontSize: 10,
                        color: colorScheme.onSurface,
                      )),
                const Gap(5),
                Row(
                  children: [
                    SizedBox(
                      width: deviceSize.width - 80,
                      child: DisplayText(
                        text: message.content,
                        style: textTheme.labelSmall!
                            .copyWith(color: colorScheme.onSurface),
                      ),
                    ),
                    DisplayText(
                      text:
                          '· ${Helpers.formatTime(message.createdAt ?? DateTime.now().toString())}',
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

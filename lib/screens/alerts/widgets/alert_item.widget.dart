import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/helpers.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class AlertItem extends StatelessWidget {
  const AlertItem({super.key, required this.notif});

  final NotificationModel notif;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    final String img = notif.typeNotifyFlag == TypeNotifyFlag.offer
        ? 'assets/images/offer.png'
        : notif.typeNotifyFlag == TypeNotifyFlag.interview
            ? 'assets/images/online-interview.png'
            : notif.typeNotifyFlag == TypeNotifyFlag.submitted
                ? 'assets/images/job-application.png'
                : 'assets/images/message.png';

    final String? title = notif.typeNotifyFlag == TypeNotifyFlag.chat
        ? notif.sender?.fullname
        : 'You have submitted to join project "Javis - AI Copilot"';
    return Opacity(
      opacity: notif.notifyFlag == NotifyFlag.read ? 0.5 : 1,
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceSize.width - 100,
                      child: DisplayText(
                        text: title ?? '',
                        style: textTheme.labelMedium!,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    if (notif.typeNotifyFlag == TypeNotifyFlag.chat)
                      SizedBox(
                        width: deviceSize.width - 100,
                        child: DisplayText(
                            text: notif.message!.content,
                            style: textTheme.labelSmall!),
                      ),
                    const Gap(10),
                    DisplayText(
                        text: Helpers.calculateTimeFromNow(
                            notif.createdAt!, context),
                        style: textTheme.labelSmall!.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 12)),
                    if (notif.typeNotifyFlag != TypeNotifyFlag.submitted &&
                        notif.typeNotifyFlag != TypeNotifyFlag.chat)
                      ElevatedButton(
                          style: buttonPrimary,
                          onPressed: () {},
                          child: DisplayText(
                            text:
                                notif.typeNotifyFlag != TypeNotifyFlag.interview
                                    ? 'Join'
                                    : 'View offer',
                            style: textTheme.labelSmall!,
                          ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

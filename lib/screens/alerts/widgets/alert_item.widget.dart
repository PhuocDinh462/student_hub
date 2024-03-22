import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

enum TypeAlert {
  text,
  invite,
  offer,
  chat,
}

class AlertItem extends StatelessWidget {
  const AlertItem(
      {super.key,
      this.type = TypeAlert.text,
      this.content,
      this.date,
      this.onHandle,
      this.name,
      this.message});
  final TypeAlert? type;
  final String? content;
  final String? name;
  final String? message;
  final String? date;
  final VoidCallback? onHandle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.onSurface.withOpacity(0.8),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: 40,
          //   height: 40,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/avatar.jpg'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Icon(
            Icons.notifications_active,
            size: 40,
            color: Colors.amber[800],
          ),
          const Gap(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (type != TypeAlert.chat)
                SizedBox(
                  width: deviceSize.width - 100,
                  child: DisplayText(
                    text:
                        'You have submitted to join project "Javis - AI Copilot"',
                    style: textTheme.labelMedium!,
                    overflow: TextOverflow.visible,
                  ),
                )
              else
                Column(
                  children: [
                    SizedBox(
                      width: deviceSize.width - 100,
                      child: DisplayText(
                        text: 'Alex Jor',
                        style: textTheme.labelMedium!,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(
                      width: deviceSize.width - 100,
                      child: DisplayText(
                        text: 'How are you doing?',
                        style: textTheme.labelMedium!,
                      ),
                    )
                  ],
                ),
              const Gap(10),
              DisplayText(
                  text: '6/6/2024',
                  style: textTheme.labelSmall!
                      .copyWith(color: colorScheme.onSurface.withOpacity(0.7))),
              if (type != TypeAlert.text && type != TypeAlert.chat)
                ElevatedButton(
                    style: buttonPrimary,
                    onPressed: onHandle,
                    child: DisplayText(
                      text: type != TypeAlert.invite ? 'Join' : 'View offer',
                      style: textTheme.labelSmall!,
                    ))
            ],
          )
        ],
      ),
    );
  }
}

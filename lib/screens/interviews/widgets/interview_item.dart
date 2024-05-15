import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/chat/video_conference.model.dart';
import 'package:student_hub/models/interview.model.dart';
import 'package:student_hub/providers/user.provider.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InterviewItem extends StatelessWidget {
  const InterviewItem({super.key, required this.interview});
  final InterviewModel interview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final f = DateFormat('dd/MM/yyyy hh:mm');
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          interview.title,
                          style: theme.textTheme.headlineLarge?.copyWith(
                              color: primary_300, fontWeight: FontWeight.w600),
                        ),
                        const Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 26,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const Gap(5),
                                    Text(
                                      f.format(
                                          DateTime.parse(interview.startTime)),
                                      style: theme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                                const Gap(15),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.credit_card_rounded,
                                      size: 26,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const Gap(5),
                                    Text(
                                      interview.meetingRoom.meetingRoomId,
                                      style: theme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 26,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const Gap(5),
                                    Text(
                                      '${DateTime.parse(interview.endTime).difference(DateTime.parse(interview.startTime)).inMinutes} ${AppLocalizations.of(context)!.minutes}',
                                      style: theme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                                const Gap(15),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.password,
                                      size: 26,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const Gap(5),
                                    Text(
                                      interview.meetingRoom.meetingRoomCode,
                                      style: theme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(20),
                        // Action buttons
                        Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: () {
                              VideoConferenceModel videoConferenceModel =
                                  VideoConferenceModel(
                                userID: userProvider.currentUser!.fullname,
                                userName: userProvider.currentUser!.fullname,
                                callID: interview.meetingRoom.meetingRoomId
                                    .toString(),
                              );

                              Get.toNamed(CompanyRoutes.videoConference,
                                  arguments: videoConferenceModel);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary_300,
                              foregroundColor: text_50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.join,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

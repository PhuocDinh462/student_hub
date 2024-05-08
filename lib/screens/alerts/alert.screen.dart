import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/alerts/widgets/alerts.widgets.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  late AppLocalizations? appLocal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocal = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      final NotificationViewModel notificationViewModel =
          Provider.of<NotificationViewModel>(context, listen: false);

      notificationViewModel.fetchNotification(
          userId: userProvider.currentUser?.userId,
          currentRole: userProvider.currentUser!.currentRole);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Consumer<NotificationViewModel>(builder: (context, notifVM, child) {
        return notifVM.loading
            ? const Center(
                child: Column(children: [
                  Gap(30),
                  CircularProgressIndicator(),
                ]),
              )
            : notifVM.notif.isEmpty
                ? Center(
                    child: Empty(
                      text: appLocal!.notifEmpty,
                    ),
                  )
                : Container(
                    width: deviceSize.width,
                    height: deviceSize.height,
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: notifVM.notif.length,
                        itemBuilder: (ctx, index) {
                          final String img = notifVM
                                      .notif[index].typeNotifyFlag ==
                                  TypeNotifyFlag.offer
                              ? 'assets/images/offer.png'
                              : notifVM.notif[index].typeNotifyFlag ==
                                      TypeNotifyFlag.interview
                                  ? 'assets/images/online-interview.png'
                                  : notifVM.notif[index].typeNotifyFlag ==
                                          TypeNotifyFlag.submitted
                                      ? 'assets/images/job-application.png'
                                      : notifVM.notif[index].typeNotifyFlag ==
                                              TypeNotifyFlag.chat
                                          ? 'assets/images/message.png'
                                          : 'assets/images/approved.png';

                          final String title = notifVM
                                      .notif[index].typeNotifyFlag ==
                                  TypeNotifyFlag.chat
                              ? '${appLocal?.newMessages} ·'
                              : notifVM.notif[index].typeNotifyFlag ==
                                      TypeNotifyFlag.interview
                                  ? '${appLocal?.newMeeting} ·'
                                  : notifVM.notif[index].typeNotifyFlag ==
                                          TypeNotifyFlag.offer
                                      ? '${appLocal?.newOffer} ·'
                                      : notifVM.notif[index].typeNotifyFlag ==
                                              TypeNotifyFlag.submitted
                                          ? '${appLocal?.newProposal} ·'
                                          : '${appLocal?.successfulHired} ·';

                          final String content = notifVM
                                      .notif[index].typeNotifyFlag ==
                                  TypeNotifyFlag.chat
                              ? '${notifVM.notif[index].sender?.fullname} (${appLocal?.sender}): ${notifVM.notif[index].message!.content}'
                              : notifVM.notif[index].typeNotifyFlag ==
                                      TypeNotifyFlag.interview
                                  ? '${appLocal?.notifInterview} "${notifVM.notif[index].message!.interview!.title}" ${appLocal?.from} ${notifVM.notif[index].sender?.fullname} ${appLocal?.at} ${Helpers.formatDateTimeToCustom(notifVM.notif[index].message!.interview!.startTime)}.'
                                  : notifVM.notif[index].typeNotifyFlag ==
                                          TypeNotifyFlag.offer
                                      ? '${appLocal?.notifOffer} ${notifVM.notif[index].sender?.fullname} ${appLocal?.company}.'
                                      : notifVM.notif[index].typeNotifyFlag ==
                                              TypeNotifyFlag.submitted
                                          ? '${notifVM.notif[index].sender?.fullname} ${appLocal?.notifSumitted} "${notifVM.notif[index].content.split(' ').last}".'
                                          : '${notifVM.notif[index].sender?.fullname} ${appLocal?.notifHired} "${notifVM.notif[index].content.split(' ').last}"';

                          return AlertItem(
                            notif: notifVM.notif[index],
                            content: content,
                            img: img,
                            title: title,
                          );
                        }));
      }),
    );
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/api/services/chat.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/utils/utils.dart';
// import 'package:student_hub/models/project.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/circle_container.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/text_field_title.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({
    super.key,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
    required this.messages,
    required this.socket,
  });
  final int projectId;
  final int senderId;
  final int receiverId;

  final List<Message> messages;
  final io.Socket socket;
  @override
  State<CreateMeeting> createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final titleController = TextEditingController();
  late DateTime pickedStartDate;
  late TimeOfDay pickedStartTime;
  late DateTime pickedEndDate;
  late TimeOfDay pickedEndTime;
  final ChatService chatService = ChatService();
  @override
  void initState() {
    super.initState();
    pickedStartDate = DateTime.now();
    pickedStartTime = TimeOfDay.now();
    pickedEndDate = DateTime.now();
    pickedEndTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    void createMeeting() {
      Navigator.pop(context);

      if (titleController.text.isEmpty) {
        MySnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.errorFilledMeeting,
          AppLocalizations.of(context)!.error,
          ContentType.failure,
        );
        return;
      } else {
        DateTime startTime = DateTime(
          pickedStartDate.year,
          pickedStartDate.month,
          pickedStartDate.day,
          pickedStartTime.hour,
          pickedStartTime.minute,
        );
        DateTime endTime = DateTime(
          pickedEndDate.year,
          pickedEndDate.month,
          pickedEndDate.day,
          pickedEndTime.hour,
          pickedEndTime.minute,
        );
        chatService.createInterview(
          titleController.text,
          'Interview created',
          startTime,
          endTime,
          widget.projectId,
          widget.senderId,
          widget.receiverId,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  CircleContainer(
                    color: primary_300.withOpacity(0.3),
                    child: const Icon(Icons.calendar_month, color: primary_300),
                  ),
                  const Gap(4),
                  Text(
                    AppLocalizations.of(context)!.scheduleInterview,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(4),
                  Divider(
                    thickness: 1.5,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  const Gap(8),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFieldTitle(
                          title: AppLocalizations.of(context)!.title,
                          hintText: AppLocalizations.of(context)!.titleHint,
                          controller: titleController,
                        ),
                        const Gap(30),
                        SelectDateTime(
                          titleDate: AppLocalizations.of(context)!.startDate,
                          titleTime: AppLocalizations.of(context)!.startTime,
                          date: pickedStartDate,
                          time: pickedStartTime,
                          onChanged: (startDate, startTime) {
                            setState(() {
                              pickedStartDate = startDate;
                              pickedStartTime = startTime;
                            });
                          },
                        ),
                        const Gap(30),
                        SelectDateTime(
                          titleDate: AppLocalizations.of(context)!.endDate,
                          titleTime: AppLocalizations.of(context)!.endTime,
                          date: pickedEndDate,
                          time: pickedEndTime,
                          onChanged: (endDate, endTime) {
                            setState(() {
                              pickedEndDate = endDate;
                              pickedEndTime = endTime;
                            });
                          },
                        ),
                        const Gap(20),
                        Divider(
                          thickness: 1.5,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        const Gap(30),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: AppLocalizations.of(context)!.cancel,
                        colorButton: Theme.of(context).colorScheme.tertiary,
                        colorText: Theme.of(context).colorScheme.onPrimary,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Button(
                        onTap: () {
                          createMeeting();
                        },
                        text: AppLocalizations.of(context)!.sendInvite,
                        colorButton: Theme.of(context).colorScheme.tertiary,
                        colorText: Theme.of(context).colorScheme.onPrimary,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

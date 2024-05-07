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

class UpdateMeeting extends StatefulWidget {
  const UpdateMeeting({
    super.key,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.socket,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
  });
  final int projectId;
  final int senderId;
  final int receiverId;
  final DateTime? startDate;
  final TimeOfDay? startTime;
  final DateTime? endDate;
  final TimeOfDay? endTime;
  final Message message;
  final io.Socket socket;
  @override
  State<UpdateMeeting> createState() => _UpdateMeetingState();
}

class _UpdateMeetingState extends State<UpdateMeeting> {
  final titleController = TextEditingController();
  final ChatService chatService = ChatService();
  late DateTime pickedStartDate;
  late TimeOfDay pickedStartTime;
  late DateTime pickedEndDate;
  late TimeOfDay pickedEndTime;
  @override
  void initState() {
    super.initState();
    pickedStartDate = widget.startDate ?? DateTime.now();
    pickedStartTime = widget.startTime ?? TimeOfDay.now();
    pickedEndDate = widget.endDate ?? DateTime.now();
    pickedEndTime = widget.endTime ?? TimeOfDay.now();
    titleController.text = widget.message.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    void updateMeeting() {
      Navigator.pop(context);

      if (titleController.text.isEmpty) {
        MySnackBar.showSnackBar(
          context,
          'Please fill all meeting\'s information',
          'Error',
          ContentType.failure,
        );
        return;
      } else {
        final DateTime newStartDate = DateTime(
          pickedStartDate.year,
          pickedStartDate.month,
          pickedStartDate.day,
          pickedStartTime.hour,
          pickedStartTime.minute,
        );
        final DateTime newEndDate = DateTime(
          pickedEndDate.year,
          pickedEndDate.month,
          pickedEndDate.day,
          pickedEndTime.hour,
          pickedEndTime.minute,
        );
        chatService.updateInterview(
          titleController.text,
          newStartDate,
          newEndDate,
          widget.message.interviewId!,
        );
      }
    }

    return Padding(
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
              'Schedule a video call interview',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            const Divider(thickness: 1.5, color: primary_300),
            const Gap(8),
            SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldTitle(
                    title: 'Title',
                    hintText: 'Enter meeting\'s title',
                    controller: titleController,
                  ),
                  const Gap(30),
                  SelectDateTime(
                    titleDate: 'Start Date',
                    titleTime: 'Start Time',
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
                    titleDate: 'End Date',
                    titleTime: 'End Time',
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
                  const Divider(thickness: 1.5, color: primary_300),
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
                  text: 'Cancel',
                  colorButton: primary_300,
                  colorText: text_50,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Button(
                  onTap: () {
                    updateMeeting();
                  },
                  text: 'Update',
                  colorButton: primary_300,
                  colorText: text_50,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/api/services/chat.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/snack_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageMeetingBubble extends StatefulWidget {
  const MessageMeetingBubble({
    super.key,
    required this.message,
    required this.receiverId,
    required this.senderId,
    this.onCancelMeeting,
    required this.projectId,
    this.onUpdateMeeting,
  });

  final int receiverId;
  final int senderId;
  final Message message;
  final int projectId;
  final VoidCallback? onCancelMeeting;
  final Function(
          DateTime startTime, DateTime endTime, String title, bool canceled)?
      onUpdateMeeting;

  @override
  State<MessageMeetingBubble> createState() => _MessageMeetingBubbleState();
}

class _MessageMeetingBubbleState extends State<MessageMeetingBubble> {
  final TextEditingController _meetingRoomIdController =
      TextEditingController();
  final TextEditingController _meetingRoomCodeController =
      TextEditingController();
  late io.Socket socket;
  final ChatService chatService = ChatService();

  @override
  void initState() {
    super.initState();
    connect();
  }

  Future<void> connect() async {
    final prefs = await SharedPreferences.getInstance();

    socket = io.io(dotenv.env['API_SERVER'], <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    final token = prefs.getString('token');
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    socket.io.options?['query'] = {'project_id': widget.projectId};

    socket.connect();

    socket.onConnect((data) => {
          print('Connected Meeting Messages'),
        });
  }

  @override
  void dispose() {
    // socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final alignment = (widget.message.senderUserId != widget.receiverId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = Theme.of(context).colorScheme.onPrimary;
    final textColor = Theme.of(context).colorScheme.surfaceVariant;
    Future<void> verifyMeetingRoom() async {
      if (_meetingRoomIdController.text.isEmpty ||
          _meetingRoomCodeController.text.isEmpty) {
        _meetingRoomCodeController.clear();
        _meetingRoomIdController.clear();
        Navigator.pop(context);

        MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.errorFilledContent,
            AppLocalizations.of(context)!.error,
            ContentType.failure);
        return;
      }
      if (_meetingRoomCodeController.text == widget.message.meetingRoomCode &&
          _meetingRoomIdController.text == widget.message.meetingRoomId) {
        Navigator.pop(context);

        Navigator.pushNamed(context, CompanyRoutes.videoCall);
      } else {
        Navigator.pop(context);

        MySnackBar.showSnackBar(
            context,
            AppLocalizations.of(context)!.wrongMeetingInfo,
            AppLocalizations.of(context)!.error,
            ContentType.failure);
      }
      _meetingRoomCodeController.clear();
      _meetingRoomIdController.clear();
    }

    void cancelMeeting() {
      chatService.disableInterview(widget.message.interviewId!);
    }

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.75),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.message.title ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: textColor,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(8),
                Text(
                  '${widget.message.endTime?.difference(widget.message.startTime!).inMinutes} mins',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: 12,
                        color: textColor.withOpacity(0.8),
                      ),
                ),
              ],
            ),
            const Gap(4),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.startTime,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
                Text(
                  '${DateFormat.yMMMd().format(widget.message.startTime!)}, ${widget.message.startTime!.hour}:${widget.message.startTime!.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
              ],
            ),
            const Gap(4),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.endTime,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
                Text(
                  '${DateFormat.yMMMd().format(widget.message.endTime!)}, ${widget.message.endTime!.hour}:${widget.message.endTime!.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
              ],
            ),
            const Gap(4),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.meetingRoomId,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
                Text(
                  '${widget.message.meetingRoomId}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
              ],
            ),
            const Gap(4),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.meetingRoomCode,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
                Text(
                  '${widget.message.meetingRoomCode}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!widget.message.canceled)
                  ElevatedButton(
                    style: buttonGreen,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text(
                              AppLocalizations.of(context)!.verifyMeetingRoom,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primary_300,
                                  ),
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _meetingRoomIdController,
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .labelMeetingRoomId,
                                        icon: const Icon(Icons.meeting_room),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _meetingRoomCodeController,
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .labelMeetingRoomCode,
                                        icon: const Icon(Icons.lock),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                child:
                                    Text(AppLocalizations.of(context)!.cancel),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child:
                                    Text(AppLocalizations.of(context)!.confirm),
                                onPressed: () {
                                  verifyMeetingRoom();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: DisplayText(
                      text: AppLocalizations.of(context)!.join,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                const Gap(8),
                if (!widget.message.canceled &&
                    widget.message.senderUserId == widget.senderId)
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.pending_outlined,
                    ),
                    iconSize: 26,
                    offset: const Offset(-36, -120),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Re-Schedule the meeting',
                        height: 60,
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              builder: (ctx) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: UpdateMeeting(
                                    projectId: widget.projectId,
                                    senderId: widget.senderId,
                                    receiverId: widget.receiverId,
                                    message: widget.message,
                                    startDate: widget.message.startTime!,
                                    startTime: TimeOfDay(
                                      hour: widget.message.startTime!.hour,
                                      minute: widget.message.startTime!.minute,
                                    ),
                                    endDate: widget.message.endTime!,
                                    endTime: TimeOfDay(
                                      hour: widget.message.endTime!.hour,
                                      minute: widget.message.endTime!.minute,
                                    ),
                                    socket: socket,
                                  ),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1
                                      : .7),
                            ),
                            const Gap(16),
                            Text(
                              AppLocalizations.of(context)!.reschedule,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Cancel the meeting',
                        height: 60,
                        onTap: () {
                          cancelMeeting();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 1
                                      : .7),
                            ),
                            const Gap(16),
                            Text(
                              AppLocalizations.of(context)!.cancelTheMeeting,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (widget.message.canceled)
                  Text(
                    AppLocalizations.of(context)!.canceledMeeting,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

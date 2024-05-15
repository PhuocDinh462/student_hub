// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/chat/chat_room.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/widgets/avatar.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_hub/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(
      {super.key,
      this.chatRoom,
      required this.project,
      required this.user,
      required this.otherUser});
  final ChatRoom? chatRoom;
  final ProjectModel project;
  final UserModel user;
  final UserModel otherUser;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  final List<Message> messages = [];
  late io.Socket socket;
  late ScrollController _scrollController;
  final FocusNode _messageFocusNode = FocusNode();
  final ChatService chatService = ChatService();
  bool isLoading = false;
  late int projectId;
  late int senderId;
  late int receiverId;
  late String receiverName;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });

    projectId = widget.project.id;
    senderId = widget.user.id;
    receiverId = widget.otherUser.id;
    receiverName = widget.otherUser.fullname!;

    _scrollController = ScrollController();
    super.initState();
    _loadMessages();
    connect();
    setState(() {
      isLoading = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    _messageFocusNode.addListener(_scrollToBottom);
  }

  void _scrollToBottom() {
    if (_messageFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeOut,
        );
      });
    }
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

    socket.io.options?['query'] = {'project_id': projectId};

    socket.connect();

    socket.onConnect((data) => {
          print('Connected'),
        });

    socket.on('RECEIVE_MESSAGE', (data) {
      setState(() {
        messages.add(Message(
          id: data['notification']['message']['id'],
          projectId: projectId,
          senderUserId: data['notification']['sender']['id'],
          receiverUserId: data['notification']['receiver']['id'],
          content: data['notification']['message']['content'],
          createdAt: DateTime.parse(data['notification']['createdAt']),
          meeting: MessageFlag
              .values[data['notification']['message']['messageFlag']],
        ));
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeOut,
        );
      });
    });

    socket.on('RECEIVE_INTERVIEW', (data) {
      if (data['notification'] != null &&
          data['notification']['content'] == 'Interview cancelled') {
        int index = messages.indexWhere(
            (element) => element.id == data['notification']['message']['id']);
        setState(() {
          messages[index] = messages[index].copyWith(
            canceled: true,
          );
        });
      } else if (data['notification'] != null &&
          data['notification']['content'] != null &&
          data['notification']['content'] == 'Interview created') {
        setState(() {
          messages.add(Message(
            id: data['notification']['message']['id'],
            projectId: projectId,
            senderUserId: data['notification']['sender']['id'],
            receiverUserId: data['notification']['receiver']['id'],
            interviewId: data['notification']['message']['interview']['id'],
            title: data['notification']['message']['interview']['title'],
            createdAt: DateTime.parse(
                data['notification']['message']['interview']['createdAt']),
            startTime: DateTime.parse(
                data['notification']['message']['interview']['startTime']),
            endTime: DateTime.parse(
                data['notification']['message']['interview']['endTime']),
            meeting: MessageFlag.interview,
            meetingRoomId: data['notification']['message']['interview']
                    ['meetingRoom']['meeting_room_id'] ??
                '',
            meetingRoomCode: data['notification']['message']['interview']
                    ['meetingRoom']['meeting_room_code'] ??
                '',
          ));
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 200,
            duration: const Duration(milliseconds: 1),
            curve: Curves.easeOut,
          );
        });
      } else if (data['notification'] != null &&
          data['notification']['content'] != null &&
          data['notification']['content'] == 'Interview updated') {
        DateTime startTime = DateTime.parse(
            data['notification']['message']['interview']['startTime']);
        DateTime endTime = DateTime.parse(
            data['notification']['message']['interview']['endTime']);
        String title = data['notification']['message']['interview']['title'];
        bool canceled =
            data['notification']['message']['interview']['disableFlag'] == 0
                ? false
                : true;
        int index = messages.indexWhere(
            (element) => element.id == data['notification']['message']['id']);
        setState(() {
          messages[index] = messages[index].copyWith(
            startTime: startTime,
            endTime: endTime,
            title: title,
            canceled: canceled,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    socket.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _loadMessages() async {
    final listMessages =
        await chatService.getConversations(receiverId, projectId);
    final List<Message> fetchMessages =
        listMessages.cast<Map<String, dynamic>>().map<Message>((msg) {
      if (msg['interview'] == null) {
        return Message(
          id: msg['id'],
          projectId: msg['projectId'] ?? projectId,
          senderUserId: msg['sender']['id'],
          receiverUserId: msg['receiver']['id'],
          content: msg['content'],
          createdAt: DateTime.parse(msg['createdAt']),
          startTime: null,
          endTime: null,
          title: '',
          meeting: MessageFlag.message,
          canceled: msg['canceled'] ?? false,
        );
      } else {
        return Message(
          id: msg['id'],
          projectId: msg['projectId'] ?? projectId,
          senderUserId: msg['sender']['id'],
          receiverUserId: msg['receiver']['id'],
          interviewId: msg['interview']['id'],
          createdAt: DateTime.parse(msg['createdAt']),
          startTime: DateTime.parse(msg['interview']['startTime']),
          endTime: DateTime.parse(msg['interview']['endTime']),
          title: msg['interview']['title'],
          meeting: MessageFlag.interview,
          canceled: msg['interview']['disableFlag'] == 0 ? false : true,
          meetingRoomId:
              msg['interview']['meetingRoom']['meeting_room_id'] ?? '',
          meetingRoomCode:
              msg['interview']['meetingRoom']['meeting_room_code'] ?? '',
        );
      }
    }).toList();
    setState(() {
      messages.clear();
      messages.addAll(fetchMessages);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    void sendMessage() async {
      final message = Message(
        projectId: projectId,
        senderUserId: senderId,
        receiverUserId: receiverId,
        content: messageController.text,
        createdAt: DateTime.now(),
        meeting: MessageFlag.message,
      );
      chatService.sendMessage(message.projectId, message.senderUserId,
          message.receiverUserId, message.content);
      messageController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            const Avatar(
              imageUrl: 'assets/images/default_avatar.png',
              radius: 18,
            ),
            const Gap(16),
            Text(
              receiverName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            offset: const Offset(-30, 45),
            color: Theme.of(context).colorScheme.secondaryContainer,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Schedule an interview',
                height: 60,
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      isScrollControlled: true,
                      builder: (ctx) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: CreateMeeting(
                            projectId: projectId,
                            senderId: senderId,
                            receiverId: receiverId,
                            messages: messages,
                            socket: socket,
                          ),
                        );
                      });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                          Theme.of(context).brightness == Brightness.dark
                              ? 1
                              : .7),
                    ),
                    const Gap(16),
                    Text(
                      AppLocalizations.of(context)!.scheduleInterview,
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
          const Gap(16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 0.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isLoading)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    Gap(50),
                  ],
                )
              else
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Avatar(
                                    imageUrl:
                                        'assets/images/default_avatar.png',
                                    radius: 30,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        receiverName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      const Text(
                                        'StudentHub',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .connectedMessage,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Divider(),
                            ],
                          ),
                        );
                      } else {
                        final message = messages[index - 1];

                        // final showImage = index - 1 == messages.length - 1 ||
                        //     (index < messages.length - 1 &&
                        //         messages[index + 1].senderUserId !=
                        //             message.senderUserId);
                        // final showImage = index - 1 == messages.length ||
                        //     messages[index - 1].senderUserId !=
                        //         message.senderUserId;
                        return Column(
                          children: [
                            const Gap(6),
                            Row(
                              mainAxisAlignment:
                                  (message.senderUserId != receiverId)
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                // if (showImage &&
                                //     message.senderUserId == senderId)
                                //   const Column(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       Avatar(
                                //         imageUrl:
                                //             'assets/images/default_avatar.png',
                                //         radius: 12,
                                //       ),
                                //     ],
                                //   ),
                                if (message.meeting == MessageFlag.interview)
                                  MessageMeetingBubble(
                                      senderId: senderId,
                                      receiverId: receiverId,
                                      message: message,
                                      projectId: projectId,
                                      onCancelMeeting: () {
                                        setState(() {
                                          // Cập nhật trạng thái của cuộc họp
                                          message.canceled = true;
                                        });
                                      },
                                      onUpdateMeeting: (DateTime startTime,
                                          DateTime endTime,
                                          String title,
                                          bool canceled) {
                                        // Cập nhật thông tin cuộc họp
                                        setState(() {
                                          message.startTime = startTime;
                                          message.endTime = endTime;
                                          message.title = title;
                                          message.canceled = canceled;
                                        });
                                      })
                                else
                                  MessageChatBubble(
                                    userId1: receiverId,
                                    userId2: senderId,
                                    message: message,
                                  ),
                                // if (showImage &&
                                //     message.senderUserId != receiverId)
                                //   const Column(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       Avatar(
                                //         imageUrl:
                                //             'assets/images/default_avatar.png',
                                //         radius: 12,
                                //       ),
                                //     ],
                                //   ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  (message.senderUserId != receiverId)
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat("MMM d").format(message.createdAt)}, ${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.color!
                                              .withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 26,
                      onPressed: () async {
                        await showModalBottomSheet(
                            context: context,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            isScrollControlled: true,
                            builder: (ctx) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: CreateMeeting(
                                  projectId: projectId,
                                  senderId: senderId,
                                  receiverId: receiverId,
                                  messages: messages,
                                  socket: socket,
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.calendar_month_sharp,
                        color: primary_300,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextFormField(
                        focusNode: _messageFocusNode,
                        controller: messageController,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.secondary),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onPrimary,
                          hintText: AppLocalizations.of(context)!.typeMessage,
                          hintStyle:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: text_400,
                                    fontSize: 15,
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              sendMessage();
                            },
                            icon: const Icon(
                              Icons.send,
                              color: primary_300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

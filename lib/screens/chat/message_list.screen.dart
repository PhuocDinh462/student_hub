import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/screens/chat/widgets/chat.widgets.dart';
import 'package:student_hub/utils/empty.dart';
import 'package:student_hub/widgets/search_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key, this.projectId = -1});
  final int projectId;

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  late List<MessageModel> lstMessage = [];
  late ScrollController _scrollController;
  late AppLocalizations? appLocal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocal = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleFetchApiMessage(_searchController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchController.dispose();
  }

  List<MessageModel> getLatestMessages(List<dynamic> results) {
    Map<String, MessageModel> latestMessages = {};

    for (var message in results) {
      MessageModel messageModel = MessageModel.fromMap(message);
      int senderId = messageModel.sender?.id ?? -1;
      int receiverId = messageModel.receiver?.id ?? -1;
      String pair = senderId.compareTo(receiverId) < 0
          ? '$senderId-$receiverId'
          : '$receiverId-$senderId';
      DateTime messageTime = DateTime.parse(messageModel.createdAt!);

      if (!latestMessages.containsKey(pair) ||
          messageTime
              .isAfter(DateTime.parse(latestMessages[pair]?.createdAt ?? ''))) {
        latestMessages[pair] = messageModel;
      }
    }

    return latestMessages.values.toList();
  }

  void handleFetchApiMessage(String name) {
    final messageService = MessageService();

    setState(() {
      isLoading = true;
    });

    (widget.projectId == -1
            ? messageService.getAllMessage()
            : messageService.getMessageByProjectId(widget.projectId))
        .then((value) {
      List<dynamic> data = value;
      List<MessageModel> res = getLatestMessages(data).reversed.toList();

      setState(() {
        lstMessage = handleFilterUser(name, res);
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  List<MessageModel> handleFilterUser(
      String name, List<MessageModel> listMessage) {
    if (name.isEmpty) {
      return listMessage;
    }

    List<MessageModel> filteredMessages = listMessage.where((message) {
      String senderName = message.sender?.fullname ?? '';
      String receiverName = message.receiver?.fullname ?? '';
      return senderName.toLowerCase().contains(name.toLowerCase()) ||
          receiverName.toLowerCase().contains(name.toLowerCase());
    }).toList();
    return filteredMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Gap(15),
        SearchBox(
            controller: _searchController, onChanged: handleFetchApiMessage),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : lstMessage.isEmpty
                  ? Center(
                      child: Empty(
                        text: appLocal!.noMessages,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: lstMessage.length,
                          itemBuilder: (ctx, index) {
                            return MessageItem(
                              message: widget.projectId == -1
                                  ? lstMessage[index]
                                  : lstMessage[index].copyWith(
                                      projectModel:
                                          ProjectModel(id: widget.projectId)),
                            );
                          }),
                    ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:student_hub/screens/chat/widgets/chat.widgets.dart';
import 'package:student_hub/widgets/search_field.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController _searchController = TextEditingController();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBox(controller: _searchController),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return const MessageItem();
                }),
          ),
        ),
      ]),
    );
  }
}

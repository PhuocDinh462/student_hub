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

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, -3),
                )
              ],
            ),
            child: SearchBox(controller: _searchController),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return const MessageItem();
                }),
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/chat.service.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/interview.model.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/interviews/widgets/interview_item.dart';

class Interviews extends StatefulWidget {
  const Interviews({super.key});

  @override
  createState() => _InterviewsState();
}

class _InterviewsState extends State<Interviews> {
  final ChatService chatService = ChatService();
  final List<InterviewModel> interviews = [];
  bool isLoading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await chatService
        .getInterviewsByUserId(userProvider.currentUser?.userId)
        .then((value) {
      interviews.addAll(value);
    }).catchError((e) {
      throw Exception(e);
    }).whenComplete(() {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: theme.colorScheme.secondaryContainer,
        backgroundColor:
            theme.brightness == Brightness.dark ? primary_200 : primary_300,
        child: Icon(
          Icons.video_call_rounded,
          color: theme.brightness == Brightness.dark ? text_700 : text_50,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: interviews.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InterviewItem(interview: interviews[index]),
                    if (index == interviews.length - 1) const Gap(85),
                  ],
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class SubmitProposal extends StatefulWidget {
  const SubmitProposal({super.key, required this.project});
  final Project project;

  @override
  State<SubmitProposal> createState() => _SubmitProposalState();
}

class _SubmitProposalState extends State<SubmitProposal> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _textController.text = widget.project.coverLetter;
    print(widget.project.description);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: colorScheme.secondaryContainer,
        body: ConstrainedBox(
            constraints: BoxConstraints(minHeight: deviceSize.height),
            child: Stack(children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DisplayText(
                          text: 'Cover letter',
                          style: textTheme.headlineLarge!),
                      const Gap(20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(10)),
                        child: CommonTextField(
                          title: 'Describe why do you fit to this project',
                          hintText: 'Your answer',
                          maxLines: 20,
                          titleStyle:
                              textTheme.bodySmall!.copyWith(color: primary_300),
                          controller: _textController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!Provider.of<GlobalProvider>(context, listen: true).isFocus)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: deviceSize.width,
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 30),
                    decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.onSurface.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, -3),
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: buttonSecondary,
                            onPressed: () {
                              Get.back();
                            },
                            child: DisplayText(
                              text: 'Cancel',
                              style: textTheme.labelLarge!.copyWith(
                                color: Colors.white,
                              ),
                            )),
                        const Gap(10),
                        ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () {},
                            child: DisplayText(
                              text: 'Submit proposal',
                              style: textTheme.labelLarge!.copyWith(
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                )
            ])));
  }
}

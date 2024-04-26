import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/dashboard/student/widgets/dashboard.widgets.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class CommonDropdownMenu extends StatefulWidget {
  const CommonDropdownMenu(
      {super.key,
      required this.labelText,
      required this.id,
      required this.proposals,
      this.actionCard,
      this.view});
  final int id;
  final String labelText;
  final ProjectDetailsView? view;
  final List<ProposalModel> proposals;
  final Function(Project)? actionCard;

  @override
  State<CommonDropdownMenu> createState() => _CommonDropdownMenuState();
}

class _CommonDropdownMenuState extends State<CommonDropdownMenu> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = Provider.of<OpenIdProvider>(context).openId == widget.id;

    final deviceSize = context.deviceSize;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
            height: 70,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(isExpanded ? 0 : 5),
                  bottomRight: Radius.circular(isExpanded ? 0 : 5),
                  topLeft: const Radius.circular(5),
                  topRight: const Radius.circular(5)),
            ),
            child: InkWell(
                onTap: () {
                  int currId =
                      Provider.of<OpenIdProvider>(context, listen: false)
                          .openId;
                  if (currId == widget.id) {
                    Provider.of<OpenIdProvider>(context, listen: false)
                        .setOpenId(0);
                  } else {
                    Provider.of<OpenIdProvider>(context, listen: false)
                        .setOpenId(widget.id);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: [
                      Expanded(
                        child: DisplayText(
                            text: widget.labelText,
                            style: textTheme.labelLarge!
                                .copyWith(color: Colors.black)),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black,
                      )
                    ])))),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(4),
            height: deviceSize.height * 0.45,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.proposals.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (ctx, index) {
                  return CardInfoProposal(
                    proposal: widget.proposals[index],
                    action: widget.actionCard,
                    view: widget.view,
                  );
                }),
          )
      ],
    );
  }
}

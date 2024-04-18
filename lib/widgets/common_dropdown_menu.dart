import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/dashboard/student/widgets/dashboard.widgets.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/widgets.dart';

class CommonDropdownMenu extends StatelessWidget {
  const CommonDropdownMenu(
      {super.key, required this.labelText, required this.id});
  final int id;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    bool isExpanded = Provider.of<OpenIdProvider>(context).openId == id;

    final deviceSize = context.deviceSize;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
            // width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              // border: Border.all(color: colorScheme.onSurface, width: 2),
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
                  if (currId == id) {
                    Provider.of<OpenIdProvider>(context, listen: false)
                        .setOpenId(0);
                  } else {
                    Provider.of<OpenIdProvider>(context, listen: false)
                        .setOpenId(id);
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: [
                      Expanded(
                        child: DisplayText(
                            text: labelText,
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
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (ctx, index) {
                  return CardInfoProposal();
                }),
          )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/widgets.dart';

class CommonDropdownMenu extends StatelessWidget {
  const CommonDropdownMenu(
      {super.key, required this.labelText, required this.id});
  final int id;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    bool isExpanded = Provider.of<OpenIdProvider>(context).openId == id;

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
            padding: const EdgeInsets.all(10),
            height: 450,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
            ),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (ctx, index) {
                  return Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayText(
                            text: 'Senior frontend developer (Fintech)',
                            style: textTheme.labelMedium!),
                        const Gap(5),
                        DisplayText(
                            text: 'Submitted 3 days ago',
                            style: textTheme.labelSmall!),
                        const Gap(10),
                        DisplayText(
                            text: 'Students are looking for...',
                            style: textTheme.labelMedium!),
                        const Gap(20),
                        const Divider(
                          color: text_400,
                          height: 2,
                        ),
                        const Gap(30)
                      ],
                    ),
                  );
                }),
          )
      ],
    );
  }
}

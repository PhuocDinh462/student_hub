import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/widgets/widgets.dart';

class CommonTabbarButton extends StatelessWidget {
  const CommonTabbarButton(
      {super.key,
      required this.listItem,
      required this.width,
      required this.space,
      required this.height});

  final List<String> listItem;
  final double width;
  final double height;
  final double space;
  @override
  Widget build(BuildContext context) {
    final IndexPageProvider indexPage = Provider.of<IndexPageProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    return CommonContainer(
      color: text_100,
      width: width,
      height: height,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: listItem.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                indexPage.setIndexDBStudent(index);
              },
              child: AnimatedContainer(
                duration: const Duration(microseconds: 500),
                margin: EdgeInsets.all(space),
                width: width / listItem.length - 2 * space,
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  color: indexPage.getIndexDBStudent == index
                      ? primary_300
                      : text_100,
                  borderRadius: indexPage.getIndexDBStudent == index
                      ? BorderRadius.circular(100)
                      : const BorderRadius.all(Radius.zero),
                ),
                child: Center(
                  child: DisplayText(
                      text: listItem[index],
                      style: textTheme.labelLarge!.copyWith(
                          color: indexPage.getIndexDBStudent == index
                              ? Colors.white
                              : Colors.black)),
                ),
              ),
            );
          }),
    );
  }
}

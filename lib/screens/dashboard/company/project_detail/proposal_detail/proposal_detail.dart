import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProposalDetail extends StatelessWidget {
  const ProposalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final int proposalId = Get.arguments;

    return Column(
      children: [
        Text(proposalId.toString()),
      ],
    );
  }
}

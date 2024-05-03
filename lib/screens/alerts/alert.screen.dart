import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/screens/alerts/widgets/alerts.widgets.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notif = Provider.of<NotificationViewModel>(context, listen: false);
      final userInfo = Provider.of<UserProvider>(context, listen: false);

      notif.fetchNotification(userInfo.currentUser?.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Consumer<NotificationViewModel>(builder: (context, notifVM, child) {
        return notifVM.loading
            ? const Center(
                child: Column(children: [
                  Gap(30),
                  CircularProgressIndicator(),
                ]),
              )
            : Container(
                width: deviceSize.width,
                height: deviceSize.height,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: notifVM.notif.length,
                    itemBuilder: (ctx, index) {
                      return AlertItem(
                        notif: notifVM.notif[index],
                      );
                    }));
      }),
    );
  }
}

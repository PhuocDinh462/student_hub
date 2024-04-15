import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:student_hub/widgets/display_text.dart';

enum SnackBarType { success, failure }

enum AlertDialogType { yesNo, infor }

class MySnackBar {
  const MySnackBar._();

  static void showSnackBar(
    BuildContext context,
    String message,
    String title,
    ContentType contentType,
  ) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> showAlertYesNoDialog(
      {required BuildContext context,
      required String title,
      required String content,
      AlertDialogType typeAlert = AlertDialogType.yesNo,
      required Function actionAccept}) async {
    final textTheme = Theme.of(context).textTheme;

    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget deleteButton = TextButton(
      onPressed: () {
        actionAccept();
      },
      child: const Text('YES'),
    );

    Widget nextButton = TextButton(
      onPressed: () {
        actionAccept();
      },
      child: const Text('Next'),
    );

    AlertDialog alert = AlertDialog(
      title: DisplayText(
        text: title,
        style: textTheme.headlineMedium!,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      ),
      content: DisplayText(
        text: content,
        style: textTheme.bodySmall!,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      ),
      actions: typeAlert == AlertDialogType.yesNo
          ? [
              cancelButton,
              deleteButton,
            ]
          : [nextButton],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

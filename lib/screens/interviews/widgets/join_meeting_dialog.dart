import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:student_hub/models/chat/video_conference.model.dart';
import 'package:student_hub/providers/user.provider.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/utils/custom_dio.dart';

class JoinMeetingDialog extends StatelessWidget {
  JoinMeetingDialog({super.key, required this.rootContext});
  final BuildContext rootContext;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _meetingRoomIdController =
      TextEditingController();
  final TextEditingController _meetingRoomCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void handleSubmit() async {
      rootContext.loaderOverlay.show();
      final UserProvider userProvider = Get.find();

      await publicDio.get(
        '/meeting-room/check-availability',
        queryParameters: {
          'meeting_room_id': _meetingRoomIdController.text,
          'meeting_room_code': _meetingRoomCodeController.text,
        },
      ).then((response) {
        if (response.data['result'] == false) {
          Get.snackbar(
            AppLocalizations.of(rootContext)!.error,
            AppLocalizations.of(rootContext)!.joinMeetingRoomError,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          VideoConferenceModel videoConferenceModel = VideoConferenceModel(
            userID: userProvider.currentUser!.userId.toString(),
            userName: userProvider.currentUser!.fullname,
            callID: _meetingRoomIdController.text,
          );
          Get.toNamed(CompanyRoutes.videoConference,
              arguments: videoConferenceModel);
        }
      }).catchError((e) {
        throw Exception('Failed to check meeting room availability: $e');
      }).whenComplete(() {
        rootContext.loaderOverlay.hide();
      });
    }

    return AlertDialog(
      scrollable: true,
      title: Text(
        AppLocalizations.of(context)!.joinMeetingRoom,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _meetingRoomIdController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.meetingRoomId,
                  icon: Icon(
                    Icons.credit_card,
                    color: theme.colorScheme.primary,
                    size: 26,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.blankInputTextError;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _meetingRoomCodeController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.meetingRoomCode,
                  icon: Icon(
                    Icons.password,
                    color: theme.colorScheme.primary,
                    size: 26,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.blankInputTextError;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(.75),
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              handleSubmit();
            }
          },
          child: Text(
            AppLocalizations.of(context)!.join,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

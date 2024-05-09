import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_hub/models/chat/video_conference.model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VideoConference extends StatelessWidget {
  const VideoConference({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoConferenceModel videoConferenceModel = Get.arguments;

    return ZegoUIKitPrebuiltCall(
      appID: int.parse(dotenv.get('ZEGO_APP_ID')),
      appSign: dotenv.get('ZEGO_APP_SIGN'),
      userID: videoConferenceModel.userID,
      userName: videoConferenceModel.userName,
      callID: videoConferenceModel.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
